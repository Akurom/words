
import 'package:flutter/material.dart';
import 'package:words/commands/base_command.dart';

class SetRowGridVisibilityCommand extends BaseCommand {

  SetRowGridVisibilityCommand(BuildContext context) : super(context);

  Future<bool> run(bool isVisible) async {
    rowGridModel.setVisibility(isVisible);
    return true;
  }
}