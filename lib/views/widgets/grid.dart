import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:words/commands/find_line_index_command.dart';
import 'package:words/commands/handle_drag_update_command.dart';
import 'package:words/commands/handle_drag_end_command.dart';
import 'package:words/commands/init_scroll_offsets_command.dart';
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

  Grid() {

  }


  @override
  Widget build(BuildContext context) {


    // init scrolloffsets
    InitScrollOffsetsCommand(context).run(screenWidth(context), screenHeight(context));

    print ('[!] GRID BUILT!');

    int? index;


    GameModel game = context.read<GameModel>();

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      dragStartBehavior: DragStartBehavior.down,
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
        //index = FindLineIndexCommand(context).run(Axis.vertical, screenWidth(context), details.globalPosition.dx,);
        // quicker ?
        index = (details.globalPosition.dx / screenWidth(context) * (game.colsNumber)).floor();
      },
      onVerticalDragUpdate: (details) async {
        HandleDragUpdateCommand(context).run(index!, Axis.vertical, screenHeight(context), details.delta.dy);
      },
      onVerticalDragEnd: (details) async {
        await HandleDragEndCommand(context).run(index!, Axis.vertical, screenHeight(context), screenWidth(context));
        index = null;
        SetRowGridVisibilityCommand(context).run(true);
      },

      onHorizontalDragStart: (details) async {
        SetColumnGridVisibilityCommand(context).run(false);
        //index = FindLineIndexCommand(context).run(Axis.horizontal, screenHeight(context), details.globalPosition.dy,);
        // quicker ?
        index = (details.globalPosition.dy / screenHeight(context) * (game.rowNumber)).floor();
      },
      onHorizontalDragUpdate: (details) {
        HandleDragUpdateCommand(context).run(index!, Axis.horizontal, screenWidth(context), details.delta.dx);
      },
      onHorizontalDragEnd: (details) async {
        await HandleDragEndCommand(context).run(index!, Axis.horizontal, screenWidth(context), screenHeight(context));
        index = null;
        SetColumnGridVisibilityCommand(context).run(true);
      },
    );
  }
}
