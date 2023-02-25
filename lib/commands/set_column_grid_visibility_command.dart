import 'package:flutter/material.dart';
import 'package:words/commands/base_command.dart';

class SetColumnGridVisibilityCommand extends BaseCommand {

  SetColumnGridVisibilityCommand(BuildContext context) : super(context);

  Future<bool> run(bool isVisible) async {
    columnGridModel.setVisibility(isVisible);
    return true;
  }
}