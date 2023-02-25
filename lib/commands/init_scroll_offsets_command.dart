import 'package:flutter/material.dart';
import 'package:words/commands/base_command.dart';
import 'package:words/models/column_model.dart';
import 'package:words/models/row_model.dart';

class InitScrollOffsetsCommand extends BaseCommand {

  InitScrollOffsetsCommand(BuildContext context) : super(context);

  Future<void> run(
    double width, double height
  ) async {

    for (ColumnModel col in columnGridModel.columns) {
      col.initScrollOffset(height);
    }
    for (RowModel row in rowGridModel.rows) {
      row.initScrollOffset(width);
    }
  }
}