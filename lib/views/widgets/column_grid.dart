import 'package:flutter/material.dart';
import 'package:words/models/column_grid_model.dart';
import 'package:words/models/column_model.dart';
import 'package:words/utils/utils.dart';
import 'package:provider/provider.dart';
import 'package:words/models/game_model.dart';
import 'package:words/const/size_constants.dart';
import 'package:words/views/widgets/column_letters.dart';

class ColumnGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    int nbCols = context.read<GameModel>().colsNumber;

    // vertical listview
    return Consumer<ColumnGridModel>(builder: (context, colGrid, child) {
      return Visibility(
        visible: colGrid.isVisible,
        child: Container(
          decoration: BoxDecoration(
              //border: Border.all(),
              //color: Colors.blue.withOpacity(0.2)
          ),

          child: Row(
            children: [
              for (int i = 0; i < nbCols; i++) ...[
                ColumnLetters(columnModel: colGrid.columns[i],),
              ],
            ],
          ),
        ),
      );
    });
  }
}
