import 'package:flutter/material.dart';
import 'dart:math';

Size getScreenSize(BuildContext context) {
  return MediaQuery.of(context).size;
}

double screenHeight(BuildContext context, {double dividedBy = 1}) {
  return getScreenSize(context).height / dividedBy;
}

double screenWidth(BuildContext context, {double dividedBy = 1}) {
  return getScreenSize(context).width / dividedBy;
}

Random random = new Random();
int randInt(int min, int max) {
  // [min; max[
  return min + random.nextInt(max - min);
}