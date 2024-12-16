import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'dart:math';

import 'package:note_app_vtwo/settings/style_and_colors_utils.dart';

class MultiBarChart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 60),
      child: Container(
        padding: const EdgeInsets.all(20),
        height: 400,
        decoration: BoxDecoration(
            color: secondaryColor, borderRadius: BorderRadius.circular(10)),
        child: BarChart(
          BarChartData(
            gridData: const FlGridData(show: true),
            titlesData: const FlTitlesData(
              leftTitles: AxisTitles(
                sideTitles: SideTitles(showTitles: true),
              ),
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(showTitles: true),
              ),
            ),
            borderData: FlBorderData(show: true),
            barGroups: _generateBarGroups(),
          ),
        ),
      ),
    );
  }

  List<BarChartGroupData> _generateBarGroups() {
    List<BarChartGroupData> barGroups = [];
    Random random = Random();

    for (int i = 0; i < 10; i++) {
      barGroups.add(
        BarChartGroupData(
          x: i * 2,
          barRods: [
            BarChartRodData(
                toY: random.nextDouble() * 10, // Data acak
                color: mainColor,
                // color: Colors.primaries[i %
                //     Colors
                //         .primaries.length], // Warna berbeda untuk setiap batang
                width: 50,
                borderRadius: BorderRadius.circular(0)),
          ],
        ),
      );
    }

    return barGroups;
  }
}
