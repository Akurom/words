/*
import 'package:flutter/material.dart';
import 'package:words/commands/set_column_layer_visibility_command.dart';
import 'package:words/const/size_constants.dart';
import 'package:words/utils/utils.dart';
import 'package:words/views/widgets/column_letters.dart';
import 'package:words/views/widgets/row_letters.dart';
import '../widgets/letter.dart';
import 'dart:developer';


class GamePageOLD extends StatelessWidget {

  GamePage();

  */
/*late List<ScrollController> _vControllers;
  late List<ScrollController> _hControllers;
  bool _isColVisible = true;
  bool _isRowVisible = false;*//*


 */
/* List<Widget> _buildWidgetListFromLetters(List<String> col, [int quarter = 0]) {
    List<Widget> list = [];
    for (String l in col) {
      list.add(Letter(letter: l));
    }
    return list;
  }

  List<Widget> _buildHorizWidget(int index) {
    List<Widget> list = [];
    for (List<String> col in letters) {
      list.add(Letter(letter: col[index]));
    }
    return list;
  }*//*


*/
/*  void _initControllers() {
    _vControllers = List.generate(11, (index) => ScrollController(initialScrollOffset: 0.0));
    _hControllers = List.generate(17, (index) => ScrollController(initialScrollOffset: 0.0));
  }*//*

  
  int _findHControllerIndex(double y, double gestureHeight) {
    return (y / gestureHeight * 17).floor();
  }
  int _findVControllerIndex(double x, double gestureWidth) {
    return (x / gestureWidth * 11).floor();
  }

  @override
  Widget build(BuildContext context) {



    log("Grid built");

    double letterHeight = screenHeight(context) * SizeConstants.letterHeightRatio;
    double letterWidth = screenWidth(context) * SizeConstants.letterWidthRatio;
    //ScrollController _ctrl = ScrollController(initialScrollOffset: 10 * letterHeight);
    double? _x;
    double? _y;
    double? _targetOffset;

    //_initControllers();

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      child: IgnorePointer(
        ignoring: true,
        child: Stack(
          children: [
            ColumnLetters(),
            RowLetters(),
          ],
        ),
      ),
      onHorizontalDragStart: (details) {
        // set col layout to invisible
        _isColVisible = false;
        _y = details.globalPosition.dy;
      },
      onHorizontalDragUpdate: (details) {
        int index = _findHControllerIndex(_y!, screenHeight(context) * 17 * SizeConstants.letterHeightRatio);
        print("${_y}, $index");
        double targetOffset = _hControllers[index].offset - details.delta.dx;
        _hControllers[index].jumpTo(targetOffset);
        _targetOffset = _targetOffset ?? 0 + targetOffset;
      },
      onHorizontalDragEnd: (details) {
        int index = _findHControllerIndex(_y!, screenHeight(context) * 17 * SizeConstants.letterHeightRatio);
        double delta = _hControllers[index].offset % letterWidth;
        double targetOffset = _hControllers[index].offset + (delta < letterWidth / 2 ? -delta : letterWidth - delta);
        _hControllers[index].animateTo(targetOffset, duration: Duration(milliseconds: 100), curve: Curves.linear);

        int newI = ((_targetOffset! + targetOffset) % (11*letterWidth)
            / letterWidth).ceil();

        _y = null;
        _targetOffset = null;
      },
      onVerticalDragStart: (details) {
        // set row layout to invisible
        SetColumnLayerVisibilityCommand().run(false);
        _x = details.globalPosition.dx;
        int index = _findVControllerIndex(_x!, screenWidth(context));
        _targetOffset = _vControllers[index].offset;
      },
      onVerticalDragUpdate: (details) {
        int index = _findVControllerIndex(_x!, screenWidth(context));
        print("${_x}, $index");
        double targetOffset = _vControllers[index].offset - details.delta.dy;
        _vControllers[index].jumpTo(targetOffset);
        // store targetOffset
        _targetOffset = _targetOffset ?? 0 + targetOffset;
      },
      onVerticalDragEnd: (details) {
        int index = _findVControllerIndex(_x!, screenWidth(context));
        double delta = _vControllers[index].offset % letterHeight;
        double targetOffset = _vControllers[index].offset + (delta < letterHeight / 2 ? -delta : letterHeight - delta);
        _vControllers[index].animateTo(targetOffset, duration: Duration(milliseconds: 100), curve: Curves.linear);
        // find index of column start
        int newI = (((_targetOffset! + targetOffset) % (17*letterHeight))
                    / letterHeight).floor();
        //print('$newI, ${letters[index][newI]}');
        _x = null;
        _targetOffset = null;
      },
    );
  }
}
*/
