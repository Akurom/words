import 'package:flutter/material.dart';
import 'package:words/commands/base_command.dart';
import 'package:words/models/game_model.dart';

class FindLineIndexCommand extends BaseCommand {

  FindLineIndexCommand(BuildContext context) : super(context);

  Future<int> run(Axis axis, double max, double p)  async {

    return (p / max * (axis == Axis.horizontal ? gameModel.rowNumber : gameModel.colsNumber)).floor();
  }
}