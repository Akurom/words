import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:words/commands/find_line_index_command.dart';
import 'package:words/commands/handle_drag_update_command.dart';
import 'package:words/commands/handle_drag_end_command.dart';
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


  @override
  Widget build(BuildContext context) {

    print ('[!] GRID BUILT!');

    double? x;
    double? y;
    int? index;


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

      onVerticalDragStart: (details) async {
        SetRowGridVisibilityCommand(context).run(false);
        index = await FindLineIndexCommand(context).run(Axis.vertical, screenWidth(context), details.globalPosition.dx,);
      },
      onVerticalDragUpdate: (details) async {
        print(index);
        HandleDragUpdateCommand(context).run(index!, Axis.vertical, screenHeight(context), details.delta.dy);
      },
      onVerticalDragEnd: (details) async {
        await HandleDragEndCommand(context).run(index!, game, Axis.vertical, screenHeight(context), screenWidth(context));
        x = null;
        index = null;
        SetRowGridVisibilityCommand(context).run(true);
      },

      onHorizontalDragStart: (details) async {
        SetColumnGridVisibilityCommand(context).run(false);
        index = await FindLineIndexCommand(context).run(Axis.horizontal, screenHeight(context), details.globalPosition.dy,);
      },
      onHorizontalDragUpdate: (details) {
        HandleDragUpdateCommand(context).run(index!, Axis.horizontal, screenWidth(context), details.delta.dx);
      },
      onHorizontalDragEnd: (details) async {
        await HandleDragEndCommand(context).run(index!, game, Axis.horizontal, screenWidth(context), screenHeight(context));
        y = null;
        index = null;
        SetColumnGridVisibilityCommand(context).run(true);
      },
    );
  }
}
