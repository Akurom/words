import 'package:flutter/cupertino.dart';
import 'package:words/models/column_model.dart';
import 'package:words/models/grid_model.dart';

class ColumnGridModel extends ChangeNotifier {
  //const ColumnGridModel() : super(_isVisible : isVisible);
  late bool _isVisible = true;
  late List<ColumnModel> _columns;

  //ColumnGridModel({required bool isVisible}) : _isVisible = isVisible;

  void setColumns(List<ColumnModel> cols) {
    _columns = cols;
  }

  List<ColumnModel> get columns => _columns;
  bool get isVisible => _isVisible;


  void setVisibility(bool isVisible) {
    _isVisible = isVisible;
    notifyListeners();
  }
}