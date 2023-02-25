import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:words/const/size_constants.dart';
import 'package:words/utils/utils.dart';

class Letter extends StatelessWidget {
  final String letter;
  final int rotateQuarter;

  const Letter({Key? key, required this.letter, this.rotateQuarter = 0}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      //decoration: BoxDecoration(border: Border.all()),
      width: screenWidth(context) * SizeConstants.letterWidthRatio,
      height: screenHeight(context) * SizeConstants.letterHeightRatio,
      child: RotatedBox(
        quarterTurns: rotateQuarter,
        child: InkWell(
            child: Text(textAlign: TextAlign.center, letter, style: TextStyle(fontSize: 40)),
            onTap: () {
              print(letter);
            }),
      ),
    );
  }
}
