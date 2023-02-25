
import 'package:words/commands/base_command.dart';

class SetColumnLayerVisibilityCommand extends BaseCommand {

  Future<bool> run(bool isVisible) async {
    columnGridModel.setVisibility(isVisible);
    return true;
  }
}