import 'package:flutter/material.dart';

class ScreenUtils {
  static double width = 0;
  static double height = 0;

  static void ukuran(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
  }
}
