
import 'package:flutter/material.dart';
import 'grid_model.dart';

class GameModel extends ChangeNotifier {

  late int _colsNumber;
  late int _rowsNumber;

  late GridModel _gridModel = GridModel();

  GameModel({
    required int colsNumber,
    required int rowsNumber
  }) {
    _colsNumber = colsNumber;
    _rowsNumber = rowsNumber;
    _gridModel.init(_colsNumber, _rowsNumber);
  }

  void init() {
    _gridModel.init(_colsNumber, _rowsNumber);
  }

  GridModel get gridModel => _gridModel;
  int get colsNumber => _colsNumber;
  int get rowNumber => _rowsNumber;
}