import 'package:flutter/material.dart';
import 'package:words/const/size_constants.dart';
import 'package:words/models/game_model.dart';
import 'package:words/utils/utils.dart';
import 'package:words/views/widgets/column_grid.dart';
import 'package:words/views/widgets/column_letters.dart';
import 'package:words/views/widgets/grid.dart';
import 'package:words/views/widgets/row_grid.dart';
import 'package:words/views/widgets/row_letters.dart';
import 'package:provider/provider.dart';

class GamePage extends StatelessWidget {
  GamePage();

  @override
  Widget build(BuildContext context) {
    int nbRows = context.read<GameModel>().rowNumber;

    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            width: screenWidth(context),
            height: screenHeight(context),
            child: Grid(),
          ),
        ],
      ),
    );
  }
}
