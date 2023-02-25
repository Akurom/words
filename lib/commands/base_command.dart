import 'package:flutter/material.dart';
import 'package:words/models/column_grid_model.dart';
import 'package:words/models/game_model.dart';
import 'package:words/models/grid_model.dart';
import 'package:provider/provider.dart';
import 'package:words/models/row_grid_model.dart';


late BuildContext _mainContext;
// The commands will use this to access the Provided models and services.
void init(BuildContext c) => _mainContext = c;

class BaseCommand {

  GameModel gameModel = _mainContext.read();
  ColumnGridModel columnGridModel = _mainContext.read();
  RowGridModel rowGridModel = _mainContext.read();
}