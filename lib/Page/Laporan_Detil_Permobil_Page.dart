import 'package:flutter/material.dart';
import 'package:note_app_vtwo/settings/style_and_colors_utils.dart';
import 'package:note_app_vtwo/widget/entity/maintenanceCarHistory.dart';
import 'package:note_app_vtwo/widget/add%20form/tambahLaporanPengeluaran.dart';
import 'package:note_app_vtwo/widget/header/userHeader_laporan_detail.dart';

class LaporanDetilPermobilPage extends StatelessWidget {
  final Function(int) onItemTapped;

  const LaporanDetilPermobilPage({super.key, required this.onItemTapped});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: const Row(
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
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Maintenancecarhistory(
                          namaOnderdil: 'Bengsin',
                          hargaOnderdil: '2.000.000',
                          tanggalInput: '10 / 02 / 2024',
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
      floatingActionButton: Container(
        decoration: BoxDecoration(
            border: Border.all(width: 2),
            borderRadius: BorderRadius.circular(15)),
        width: 70,
        height: 70,
        child: FloatingActionButton(
          backgroundColor: secondaryColor,
          onPressed: () {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return Tambahlaporanpengeluaran();
                });
          },
          child: Container(
            child: Icon(
              Icons.add,
              color: mainColor,
              size: 50,
            ),
          ),
        ),
      ),
    );
  }
}
