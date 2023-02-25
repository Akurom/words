import 'package:flutter/cupertino.dart';

class ItemModel extends ChangeNotifier {

  String? _letter;
  ItemModel.initLetter({required String letter})
      : _letter = letter;

  void setLetter(String letter) {
    _letter = letter;
    notifyListeners();
  }

  String get letter => _letter ?? " ";
}