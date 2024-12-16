import 'package:flutter/material.dart';
import 'package:note_app_vtwo/settings/style_and_colors_utils.dart';
import 'package:note_app_vtwo/widget/maintenanceCarHistory.dart';
import 'package:note_app_vtwo/widget/userHeader_laporan_detail.dart';

class LaporanDetilPermobilPage extends StatelessWidget {
  final Function(int) onItemTapped;

  const LaporanDetilPermobilPage({super.key, required this.onItemTapped});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: bgColor,
      body: Row(
        children: [
          Expanded(
            child: Column(
              children: [
                UserheaderLaporanDetail(
                    titlePage: 'Laporan Detail',
                    iconHeader: 'assets/report icon.svg'),
                SizedBox(
                  height: 20,
                ),
                Maintenancecarhistory(
                  namaOnderdil: 'Bengsin',
                  hargaOnderdil: '2.000.000',
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
