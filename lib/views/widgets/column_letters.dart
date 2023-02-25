import 'package:flutter/material.dart';
import 'package:words/models/column_model.dart';
import 'package:words/utils/utils.dart';
import 'package:provider/provider.dart';
import 'package:words/models/game_model.dart';
import 'package:words/utils/utils.dart';
import 'package:words/const/size_constants.dart';
import 'package:words/views/widgets/letter.dart';


class ColumnLetters extends StatelessWidget {

  final ColumnModel columnModel;

  ColumnLetters({required this.columnModel});

  @override
  Widget build(BuildContext context) {


    int nbRows = context.read<GameModel>().rowNumber;
    double letterHeight = screenHeight(context) / nbRows;

    return ChangeNotifierProvider<ColumnModel>.value(
      value: columnModel,
      child: Consumer<ColumnModel>(builder: (context, col, child) {
        return Expanded(
          child: ListView.builder(
            scrollDirection: Axis.vertical,
            controller: col.scrollController,
            itemExtent: letterHeight,
            itemBuilder: (buildContext, index) {
              // build list of widgets
              return Letter(letter: col.items[index % col.items.length].letter);
            },
          ),
        );
      }),
    );
  }
}
