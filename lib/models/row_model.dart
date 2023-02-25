
import 'package:flutter/cupertino.dart';
import 'item_model.dart';

class RowModel extends ChangeNotifier {

  late List<ItemModel> _items;
  late ScrollController _scrollController;

  RowModel({required List<ItemModel> items, required double scrollOffset}) {
    _items = items;
    _scrollController = ScrollController(initialScrollOffset: scrollOffset);
  }

  ScrollController get scrollController => _scrollController;
  List<ItemModel> get items => _items;

}