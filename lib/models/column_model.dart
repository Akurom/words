
import 'package:flutter/cupertino.dart';
import 'item_model.dart';

class ColumnModel extends ChangeNotifier {

  late List<ItemModel> _items;
  late ScrollController _scrollController;

  ColumnModel({required List<ItemModel> items}) {
    _items = items;

  }

  ScrollController get scrollController => _scrollController;
  List<ItemModel> get items => _items;

  void initScrollOffset(double offset) {
    _scrollController = ScrollController(initialScrollOffset: offset);
  }

  void setScrollOffset(double offset) {
    _scrollController.jumpTo(offset);
    notifyListeners();
  }

  void set items(List<ItemModel> newItems) {
    //newItems = [...newItems, ...newItems];
    _items = newItems;
  }
}