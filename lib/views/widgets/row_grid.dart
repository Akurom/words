import 'package:flutter/material.dart';
import 'package:words/models/row_grid_model.dart';
import 'package:words/utils/utils.dart';
import 'package:words/const/size_constants.dart';
import 'package:words/views/widgets/row_letters.dart';
import 'package:provider/provider.dart';
import 'package:words/models/game_model.dart';

class RowGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    int nbRows = context.read<GameModel>().rowNumber;

    // horizontal listview
    return Consumer<RowGridModel>(builder: (context, rowGrid, child) {
      return Visibility(
        visible: rowGrid.isVisible,
        child: Container(
          decoration: BoxDecoration(border: Border.all(), color: Colors.red.withOpacity(0.2)),

          child: Column(
            children: [
              for (int i = 0; i < nbRows; i++) ...[
                RowLetters(rowModel: rowGrid.rows[i]),
              ],
            ],
          ),
        ),
      );
    });
  }
}
