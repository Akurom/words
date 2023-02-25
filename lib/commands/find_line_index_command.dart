import 'package:flutter/material.dart';
import 'package:words/commands/base_command.dart';
import 'package:words/models/game_model.dart';

class FindLineIndexCommand extends BaseCommand {

  FindLineIndexCommand(BuildContext context) : super(context);

  int run(Axis axis, double max, double p) {
    return (p / max * (axis == Axis.horizontal ? gameModel.rowNumber : gameModel.colsNumber)).floor();
  }
}