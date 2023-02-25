import 'package:flutter/material.dart';
import 'package:words/models/column_grid_model.dart';
import 'package:words/models/game_model.dart';
import 'package:words/models/grid_model.dart';
import 'package:provider/provider.dart';
import 'package:words/models/row_grid_model.dart';

/*
late BuildContext _mainContext;
// The commands will use this to access the Provided models and services.
void init(BuildContext c) => _mainContext = c;*/

class BaseCommand {
  static BuildContext? _lastKnownRoot;

  /// Provide all commands access to the global context & navigator
  late BuildContext context;

  BaseCommand(BuildContext c) {
    /// Get root context
    /// If we're passed a context that is known to be root, skip the lookup, it will throw an error otherwise.
    context = (c == _lastKnownRoot) ? c : Provider.of(c, listen: false);
    _lastKnownRoot = context;
  }

  T getProvided<T>() => Provider.of<T>(context, listen: false);

  /// Convenience lookup methods for all commands to share
  ///
  /// Models
  GameModel get gameModel => getProvided();
  ColumnGridModel get columnGridModel => getProvided();//= _mainContext.read();
  RowGridModel get rowGridModel => getProvided();//= _mainContext.read();
}