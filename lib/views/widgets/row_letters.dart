import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:words/models/game_model.dart';
import 'package:words/models/row_model.dart';
import 'package:words/utils/utils.dart';
import 'package:words/const/size_constants.dart';
import 'package:words/views/widgets/letter.dart';

class RowLetters extends StatelessWidget {
  final RowModel rowModel;

  RowLetters({required this.rowModel});

  @override
  Widget build(BuildContext context) {
    int nbCols = context.read<GameModel>().colsNumber;

    double letterWidth = screenWidth(context) / nbCols;

    return ChangeNotifierProvider<RowModel>.value(
      value: rowModel,
      child: Consumer<RowModel>(builder: (context, row, child) {
        return Expanded(
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            controller: row.scrollController,
            itemExtent: letterWidth,
            itemBuilder: (buildContext, index) {
              return Letter(letter: row.items[index % row.items.length].letter);
            },
          ),
        );
      }),
    );
  }
}
