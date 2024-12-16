import 'package:flutter/material.dart';
import 'package:note_app_vtwo/settings/style_and_colors_utils.dart';

import 'package:note_app_vtwo/widget/entitasMobil.dart';
import 'package:note_app_vtwo/widget/userHeader_custom.dart';

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
                ),
                Entitasmobil(
                  iconAction: 'assets/delete icon.svg',
                  navigate: () {},
                  number: 1,
                  platnomor: 'F 1234 CD',
                ),
                Entitasmobil(
                  iconAction: 'assets/delete icon.svg',
                  navigate: () {},
                  number: 1,
                  platnomor: 'F 1234 CD',
                ),
                Entitasmobil(
                  iconAction: 'assets/delete icon.svg',
                  navigate: () {},
                  number: 1,
                  platnomor: 'F 1234 CD',
                ),
                Entitasmobil(
                  iconAction: 'assets/delete icon.svg',
                  navigate: () {},
                  number: 1,
                  platnomor: 'F 1234 CD',
                ),
                Entitasmobil(
                  iconAction: 'assets/delete icon.svg',
                  navigate: () {},
                  number: 1,
                  platnomor: 'F 1234 CD',
                ),
                Entitasmobil(
                  iconAction: 'assets/delete icon.svg',
                  navigate: () {},
                  number: 1,
                  platnomor: 'F 1234 CD',
                ),
                Entitasmobil(
                  iconAction: 'assets/delete icon.svg',
                  navigate: () {},
                  number: 1,
                  platnomor: 'F 1234 CD',
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
          onPressed: () {},
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
