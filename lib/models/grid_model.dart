import 'package:flutter/material.dart';
import 'package:words/models/column_grid_model.dart';
import 'package:words/models/column_model.dart';
import 'package:words/models/row_grid_model.dart';
import 'package:words/models/row_model.dart';
import 'package:words/views/widgets/column_grid.dart';
import 'package:words/views/widgets/row_grid.dart';
import 'item_model.dart';
import 'package:words/utils/utils.dart';

class GridModel with ChangeNotifier {

  //late List<List<ItemModel>> _grid;
  late ColumnGridModel _columnGrid = ColumnGridModel();
  late RowGridModel _rowGrid = RowGridModel();


  void init(int nbCols, int nbRows) {

    String chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";

    List<List<ItemModel>> grid = List.generate(nbCols, (index)
      => List.generate(nbRows, (index)
      => ItemModel.initLetter(letter: chars[randInt(0, chars.length)])));

    List<ColumnModel> cols = [];
    List<RowModel> rows = [];

    for (List<ItemModel> col in grid) {
      cols.add(ColumnModel(items: col, scrollOffset: 0.0));
    }
    for  (int i = 0; i < grid[0].length; i ++) {
      List<ItemModel> rowItems = [];
      for (List<ItemModel> col in grid) {
        rowItems.add(col[i]);
      }
      rows.add(RowModel(items: rowItems, scrollOffset: 0.0));
    }

    _columnGrid.setColumns(cols);
    _rowGrid.setRows(rows);

    _columnGrid.setVisibility(true);
    _rowGrid.setVisibility(true);
  }

  ColumnGridModel get columnGrid => _columnGrid;
  RowGridModel get rowsGrid => _rowGrid;



}