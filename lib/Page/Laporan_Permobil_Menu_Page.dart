import 'package:flutter/material.dart';
import 'package:note_app_vtwo/Page/Laporan_Detil_Permobil_Page.dart';
import 'package:note_app_vtwo/settings/style_and_colors_utils.dart';
import 'package:note_app_vtwo/widget/entitasLaporanMobil.dart';
import 'package:note_app_vtwo/widget/userHeader_custom.dart';

class LaporanPermobilMenuPage extends StatelessWidget {
  const LaporanPermobilMenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: Row(
        children: [
          Expanded(
              child: Column(
            children: [
              const UserheaderCustom(iconHeader: 'assets/report icon.svg'),
              EntitasLaporanMobil(
                iconAction: 'assets/arrow icon v2.svg',
                navigate: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => LaporanDetilPermobilPage()));
                },
                number: 1,
                platnomor: 'F 1234 CD',
              ),
              EntitasLaporanMobil(
                iconAction: 'assets/arrow icon v2.svg',
                navigate: () {},
                number: 1,
                platnomor: 'F 1234 CD',
              ),
              EntitasLaporanMobil(
                iconAction: 'assets/arrow icon v2.svg',
                navigate: () {},
                number: 1,
                platnomor: 'F 1234 CD',
              ),
              EntitasLaporanMobil(
                iconAction: 'assets/arrow icon v2.svg',
                navigate: () {},
                number: 1,
                platnomor: 'F 1234 CD',
              ),
              EntitasLaporanMobil(
                iconAction: 'assets/arrow icon v2.svg',
                navigate: () {},
                number: 1,
                platnomor: 'F 1234 CD',
              ),
              EntitasLaporanMobil(
                iconAction: 'assets/arrow icon v2.svg',
                navigate: () {},
                number: 1,
                platnomor: 'F 1234 CD',
              ),
              EntitasLaporanMobil(
                iconAction: 'assets/arrow icon v2.svg',
                navigate: () {},
                number: 1,
                platnomor: 'F 1234 CD',
              ),
            ],
          ))
        ],
      ),
    );
  }
}
