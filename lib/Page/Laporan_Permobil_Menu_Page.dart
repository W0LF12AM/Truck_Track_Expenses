import 'package:flutter/material.dart';
import 'package:note_app_vtwo/settings/style_and_colors_utils.dart';
import 'package:note_app_vtwo/widget/entity/entitasLaporanMobil.dart';
import 'package:note_app_vtwo/widget/header/userHeader_custom.dart';

class LaporanPermobilMenuPage extends StatelessWidget {
  final Function(int) onItemTapped;

  const LaporanPermobilMenuPage({super.key, required this.onItemTapped});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: Row(
        children: [
          Expanded(
              child: Column(
            children: [
              UserheaderCustom(
                iconHeader: 'assets/report icon.svg',
                titleHeader: 'Laporan Mobil',
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      EntitasLaporanMobil(
                        sisaBudget: '20.000.000',
                        tanggalInput: 'DD / MM / YYYY',
                        navigate: () {
                          onItemTapped(4);
                        },
                        number: 1,
                        platnomor: 'F 1234 CD',
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ))
        ],
      ),
    );
  }
}
