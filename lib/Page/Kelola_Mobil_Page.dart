import 'package:flutter/material.dart';

import 'package:note_app_vtwo/settings/style_and_colors_utils.dart';
import 'package:note_app_vtwo/widget/dialog/dilaogPeringatanHapusData.dart';

import 'package:note_app_vtwo/widget/entity/entitasMobil.dart';
import 'package:note_app_vtwo/widget/add%20form/tambahMobilDialog.dart';
import 'package:note_app_vtwo/widget/header/userHeader_custom.dart';

class KelolaMobilPage extends StatelessWidget {
  const KelolaMobilPage({super.key});

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
                  iconHeader: 'assets/car icon.svg',
                  titleHeader: 'Kelola Mobil',
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Entitasmobil(
                          navigate: () {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return Dialog(
                                    backgroundColor: Colors.transparent,
                                    child: Dilaogperingatanhapusdata(),
                                  );
                                });
                          },
                          number: 1,
                          platnomor: 'F 1234 CD',
                        ),
                        SizedBox(
                          height: 300,
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
      floatingActionButton: GestureDetector(
        onTap: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return Tambahmobildialog();
              });
        },
        child: Container(
          decoration: BoxDecoration(
              border: Border.all(width: 2),
              borderRadius: BorderRadius.circular(15)),
          width: 70,
          height: 70,
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
