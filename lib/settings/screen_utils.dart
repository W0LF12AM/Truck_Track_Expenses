import 'package:flutter/material.dart';

class ScreenUtils {
  static double getLebar(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  static double getTinggi(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  static double getUkuranResponsiv(BuildContext context,
      {double minSize = 100, double maxSize = 150}) {
    double width = getLebar(context);
    return width < 600 ? minSize : maxSize;
  }

  static double getUkuranWidget(BuildContext context,
      {required double baseSize}) {
    double width = getLebar(context);
    return width < 600 ? baseSize : baseSize * 0.7;
  }

  static Size getUkuranMinimumLayar(BuildContext context) {
    double width = getLebar(context);
    double height = getTinggi(context);

    double minWidth = 1500;
    double minHeigth = 900;

    return Size(width < minWidth ? minWidth : width,
        height < minHeigth ? minHeigth : height);
  }
}
