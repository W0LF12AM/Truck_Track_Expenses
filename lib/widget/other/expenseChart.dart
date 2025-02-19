import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:note_app_vtwo/data/databaseHelper.dart';
import 'package:note_app_vtwo/function/provider.dart';
import 'dart:math';

import 'package:note_app_vtwo/settings/style_and_colors_utils.dart';
import 'package:provider/provider.dart';

class MultiBarChart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Provider.of<TruckProvider>(context, listen: false)
        .loadMonthlyMaintenanceData();
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.03,
          vertical: MediaQuery.sizeOf(context).height * 0.0001),
      child: Container(
        padding: const EdgeInsets.all(15),
        height: MediaQuery.of(context).size.height * 0.4,
        decoration: BoxDecoration(
            color: secondaryColor, borderRadius: BorderRadius.circular(10)),
        child:
            Consumer<TruckProvider>(builder: (context, truckProvider, child) {
          if (truckProvider.maintenanceData.isEmpty) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return BarChart(
            BarChartData(
              gridData: const FlGridData(show: true),
              titlesData: FlTitlesData(
                leftTitles: AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    reservedSize: 38,
                    getTitlesWidget: (value, meta) {
                      switch (value.toInt()) {
                        case 0:
                          return Text('Jan');
                        case 1:
                          return Text('Feb');
                        case 2:
                          return Text('Mar');
                        case 3:
                          return Text('Apr');
                        case 4:
                          return Text('May');
                        case 5:
                          return Text('Jun');
                        case 6:
                          return Text('Jul');
                        case 7:
                          return Text('Aug');
                        case 8:
                          return Text('Sep');
                        case 9:
                          return Text('Oct');
                        case 10:
                          return Text('Nov');
                        case 11:
                          return Text('Dec');
                        default:
                          return Text('');
                      }
                    },
                  ),
                ),
              ),
              borderData: FlBorderData(show: true),
              barGroups: _generateBarGroups(truckProvider.maintenanceData),
            ),
          );
        }),
      ),
    );
  }

  List<BarChartGroupData> _generateBarGroups(List<double> maintenanceData) {
    List<BarChartGroupData> barGroups = [];

    for (int i = 0; i < maintenanceData.length; i++) {
      barGroups.add(
        BarChartGroupData(
          x: i,
          barRods: [
            BarChartRodData(
                toY: maintenanceData[i],
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
