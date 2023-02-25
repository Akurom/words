import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:words/commands/set_column_grid_visibility_command.dart';
import 'package:words/commands/set_row_grid_visibility_command.dart';
import 'package:words/const/size_constants.dart';
import 'package:words/models/game_model.dart';
import 'package:words/models/grid_model.dart';
import 'package:words/utils/utils.dart';
import 'package:words/views/widgets/column_grid.dart';
import 'package:words/views/widgets/column_letters.dart';
import 'package:words/views/widgets/row_grid.dart';
import 'package:words/views/widgets/row_letters.dart';

class Grid extends StatelessWidget {


  Grid();



  int _findLineIndex(GameModel game, Axis axis, double max, double p) {
    return (p / max * (axis == Axis.horizontal ? game.rowNumber : game.colsNumber)).floor();
  }


  Future<void> _handleDragEnd(
      GameModel game,
      Axis axis,
      axisSize,
      double crossAxisSize,
      double crossPosition)
  async {

    double itemSize = axisSize / (axis == Axis.horizontal ? game.colsNumber : game.rowNumber);
    // find coll or row index in corresponding model
    int index = _findLineIndex(game, axis, crossAxisSize, crossPosition);

    late ScrollController scrollController;
    if (axis == Axis.horizontal) {
      scrollController = game.gridModel.rowsGrid.rows[index].scrollController;
    } else if (axis == Axis.vertical) {
      scrollController = game.gridModel.columnGrid.columns[index].scrollController;
    }
    double offset = scrollController.offset;
    // find delta from aligned letters (sticky)
    double delta = offset % itemSize;
    double targetOffset = offset + (delta < itemSize / 2 ? -delta : itemSize - delta);
    // stick
    scrollController
        .animateTo(targetOffset, duration: Duration(milliseconds: 500), curve: Curves.linear);

    // find new index of line start to restructure grid
    int nbItemsPerLine = axis == Axis.horizontal ? game.rowNumber : game.colsNumber;
    int newI = (targetOffset % (nbItemsPerLine * itemSize) / itemSize).round();

    var items;
    //String letter = items[newI].letter;
    //print ('$newI $letter');

    // restructure
    if (axis == Axis.horizontal) {
      items = game.gridModel.rowsGrid.rows[index].items;
      // ****
      print (items.map((e) => e.letter));
      items = items.sublist(newI) + items.sublist(0, newI);
      print (items.map((e) => e.letter));

      game.gridModel.rowsGrid.rows[index].items = items;

      for (int i = 0; i < game.gridModel.columnGrid.columns.length; i++) {
        game.gridModel.columnGrid.columns[i].items[index] = items[i];
      }
    } else if (axis == Axis.vertical) {

      items = game.gridModel.columnGrid.columns[index].items;
      // ****
      print (items.map((e) => e.letter));
      items = items.sublist(newI) + items.sublist(0, newI);
      print (items.map((e) => e.letter));
      game.gridModel.columnGrid.columns[index].items = items;
      // structure rowGrid.rows
      for (int i = 0; i < game.gridModel.rowsGrid.rows.length; i++) {
        game.gridModel.rowsGrid.rows[i].items[index] = items[i];
      }
      print((game.gridModel.columnGrid.columns[index].items).map((e) => e.letter));
    }


  }




  @override
  Widget build(BuildContext context) {

    print ('[!] GRID BUILT!');

    double? _x;
    double? _y;
    double? _targetOffset;
    
    double letterWidth = screenWidth(context) * SizeConstants.letterWidthRatio;

    GameModel game = context.read<GameModel>();



    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      child: IgnorePointer(
        ignoring: true,
        child: Stack(
          children: [
            ColumnGrid(),
            RowGrid(),
          ],
        ),
      ),
      onVerticalDragStart: (details) {

        SetRowGridVisibilityCommand(context).run(false);

        _x = details.globalPosition.dx;
        int index = _findLineIndex(game, Axis.vertical, screenWidth(context), _x! );
        _targetOffset = game.gridModel.columnGrid.columns[index].scrollController.offset;
        print('onVerticalDragStart $_targetOffset');
      },
      onVerticalDragUpdate: (details) {
        int index = _findLineIndex(game, Axis.vertical, screenWidth(context), _x! );
        //print("update drag ${_x}, $index");
        double targetOffset = game.gridModel.columnGrid.columns[index].scrollController.offset
            - details.delta.dy;
        game.gridModel.columnGrid.columns[index].scrollController.jumpTo(targetOffset);
        // store targetOffset
        _targetOffset = _targetOffset ?? 0 + targetOffset;
      },
      onVerticalDragEnd: (details) async {
        await _handleDragEnd(game, Axis.vertical, screenHeight(context), screenWidth(context), _x!);
        _x = null;
        _targetOffset = null;


        SetRowGridVisibilityCommand(context).run(true);
      },
      onHorizontalDragStart: (details) {

        SetColumnGridVisibilityCommand(context).run(false);

        _y = details.globalPosition.dy;
        int index = _findLineIndex(game, Axis.horizontal, screenHeight(context), _y! );
        _targetOffset = game.gridModel.rowsGrid.rows[index].scrollController.offset;
      },
      onHorizontalDragUpdate: (details) {
        int index = _findLineIndex(game, Axis.horizontal, screenHeight(context), _y! );
        double targetOffset = game.gridModel.rowsGrid.rows[index].scrollController.offset
            - details.delta.dx;
        game.gridModel.rowsGrid.rows[index].scrollController.jumpTo(targetOffset);
        // store targetOffset
        _targetOffset = _targetOffset ?? 0 + targetOffset;
      },
      onHorizontalDragEnd: (details) async {
        await _handleDragEnd(game, Axis.horizontal, screenWidth(context), screenHeight(context), _y!);
        _y = null;
        _targetOffset = null;

        SetColumnGridVisibilityCommand(context).run(true);
      },
    );
  }
}
