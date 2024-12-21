import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:note_app_vtwo/settings/style_and_colors_utils.dart';
import 'package:note_app_vtwo/widget/other/expenseChart.dart';
import 'package:note_app_vtwo/widget/header/userHeader_landing_page.dart';

class LandingPage extends StatefulWidget {
  LandingPage({super.key, required this.onItemTapped});

  final Function(int) onItemTapped;

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
    return Scaffold(
      backgroundColor: bgColor,
      body: Row(
        children: [
          Expanded(
            child: Column(
              children: [
                UserheaderLandingPage(
                  onItemTapped: widget.onItemTapped,
                ),
                SizedBox(
                  height: MediaQuery.sizeOf(context).height * 0.02,
                ),
                MultiBarChart()
              ],
            ),
          )
        ],
      ),
    );
  }
}
