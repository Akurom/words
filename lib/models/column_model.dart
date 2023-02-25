
import 'package:flutter/cupertino.dart';
import 'item_model.dart';

class ColumnModel extends ChangeNotifier {

  late List<ItemModel> _items;
  late ScrollController _scrollController;

  ColumnModel({required List<ItemModel> items, required double scrollOffset}) {
    _items = items;
    _scrollController = ScrollController(initialScrollOffset: scrollOffset);
  }

  ScrollController get scrollController => _scrollController;
  List<ItemModel> get items => _items;
}