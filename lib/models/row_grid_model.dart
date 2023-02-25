
import 'package:flutter/cupertino.dart';
import 'package:words/models/row_model.dart';

class RowGridModel extends ChangeNotifier {

  late bool _isVisible;
  late List<RowModel> _rows;

  //RowGridModel({required bool isVisible}): _isVisible = isVisible;

  void setRows(List<RowModel> rows) {
    _rows = rows;
  }

  List<RowModel> get rows => _rows;
  bool get isVisible => _isVisible;

  void setVisibility(bool isVisible) {
    _isVisible = isVisible;
    notifyListeners();
  }
}