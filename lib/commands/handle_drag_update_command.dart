import 'package:flutter/material.dart';
import 'package:words/commands/base_command.dart';
import 'package:words/commands/find_line_index_command.dart';
import 'package:words/models/game_model.dart';

class HandleDragUpdateCommand extends BaseCommand {

  HandleDragUpdateCommand(BuildContext context) : super(context);

  Future<void> run(
      int index,
      Axis axis,
      double crossAxisSize,
      double delta
      ) async {

    var line;
    if (axis == Axis.horizontal) {
      line = gameModel.gridModel.rowsGrid.rows[index];
    } else if (axis == Axis.vertical) {
      line = gameModel.gridModel.columnGrid.columns[index];
    }

    double targetOffset = line.scrollController.offset - delta;
    line.scrollController.jumpTo(targetOffset);
  }
}