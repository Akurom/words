
import 'package:flutter/material.dart';
import 'package:words/commands/base_command.dart';
import 'package:words/commands/find_line_index_command.dart';
import 'package:words/models/game_model.dart';

class HandleDragEndCommand extends BaseCommand {

  HandleDragEndCommand(BuildContext context) : super(context);

  Future<void> run(
      int index,
      Axis axis,
      double axisSize,
      double crossAxisSize
      )
  async {
    double itemSize = axisSize / (axis == Axis.horizontal ? gameModel.colsNumber : gameModel.rowNumber);
    // find col or row index in corresponding model

    late ScrollController scrollController;
    if (axis == Axis.horizontal) {
      scrollController = gameModel.gridModel.rowsGrid.rows[index].scrollController;
    } else if (axis == Axis.vertical) {
      scrollController = gameModel.gridModel.columnGrid.columns[index].scrollController;
    }
    double offset = scrollController.offset;
    // find delta from aligned letters (sticky)
    double delta = offset % itemSize;
    double targetOffset = offset + (delta < itemSize / 2 ? -delta : itemSize - delta);
    // stick
    await scrollController
        .animateTo(targetOffset, duration: Duration(milliseconds: 100), curve: Curves.linear);

    // find new index of line start to restructure grid
    int nbItemsPerLine = axis == Axis.vertical ? gameModel.rowNumber : gameModel.colsNumber;
    int newI = (((targetOffset % axisSize) % (nbItemsPerLine * itemSize)) / itemSize).round();

    var items;

    // restructure
    if (axis == Axis.horizontal) {  // ROW
      items = gameModel.gridModel.rowsGrid.rows[index].items;
      // ****
      items = items.sublist(newI) + items.sublist(0, newI);

      gameModel.gridModel.rowsGrid.rows[index].items = items;//[...items, ...items];
      gameModel.gridModel.rowsGrid.rows[index].setScrollOffset(axisSize);

      for (int i = 0; i < gameModel.gridModel.columnGrid.columns.length; i++) {
        gameModel.gridModel.columnGrid.columns[i].items[index] = items[i];
        gameModel.gridModel.columnGrid.columns[i].items[index + gameModel.rowNumber] = items[i];
      }
    } else if (axis == Axis.vertical) { // COLUMN

      items = gameModel.gridModel.columnGrid.columns[index].items;
      items = items.sublist(newI) + items.sublist(0, newI);

      gameModel.gridModel.columnGrid.columns[index].items = items;//[...items, ...items];
      gameModel.gridModel.columnGrid.columns[index].setScrollOffset(axisSize);

      // structure rowGrid.rows
      for (int i = 0; i < gameModel.gridModel.rowsGrid.rows.length; i++) {
        gameModel.gridModel.rowsGrid.rows[i].items[index] = items[i];
        gameModel.gridModel.rowsGrid.rows[i].items[index + gameModel.colsNumber] = items[i];
      }
    }
  }
}