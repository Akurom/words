
import 'package:flutter/material.dart';
import 'package:words/commands/base_command.dart';
import 'package:words/commands/find_line_index_command.dart';
import 'package:words/models/game_model.dart';

class HandleDragEndCommand extends BaseCommand {

  HandleDragEndCommand(BuildContext context) : super(context);

  Future<void> run(
      int index,
      GameModel game,
      Axis axis,
      double axisSize,
      double crossAxisSize
      )
  async {
    double itemSize = axisSize / (axis == Axis.horizontal ? game.colsNumber : game.rowNumber);
    // find col or row index in corresponding model

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
    await scrollController
        .animateTo(targetOffset, duration: Duration(milliseconds: 100), curve: Curves.linear);

    // find new index of line start to restructure grid
    int nbItemsPerLine = axis == Axis.horizontal ? game.rowNumber : game.colsNumber;
    int newI = ((targetOffset % axisSize) % (nbItemsPerLine * itemSize) / itemSize).round();

    var items;

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
      //print((game.gridModel.columnGrid.columns[index].items).map((e) => e.letter));
    }


  }
}