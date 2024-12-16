import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:note_app_vtwo/settings/style_and_colors_utils.dart';
import 'package:note_app_vtwo/widget/cardLaporanHeader.dart';
import 'package:note_app_vtwo/widget/headerLaporanMobil.dart';

class UserheaderLaporanDetail extends StatelessWidget {
  const UserheaderLaporanDetail(
      {super.key, required this.titlePage, required this.iconHeader});

  final String titlePage;
  final String iconHeader;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.maxFinite,
          height: 350,
          decoration: BoxDecoration(color: mainColor),
          child: Padding(
            padding: const EdgeInsets.only(left: 40, right: 40, top: 40),
            child: Column(
              children: [
                Row(
                  children: [
                    SvgPicture.asset(
                      iconHeader,
                      color: secondaryColor,
                      height: 40,
                      width: 40,
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Text(
                      titlePage,
                      style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: 32,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                Headerlaporanmobil(
                    number: 1,
                    platnomor: 'F 1234 ED',
                    navigate: () {},
                    textButton: 'Download')
              ],
            ),
          ),
        ),
        const Padding(
          padding: EdgeInsets.only(top: 300, left: 40, right: 40),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Cardlaporanheader(
                colorGradient: budgetColor,
                titleCard: 'Budget',
                budget: '22.000.000',
              ),
              Cardlaporanheader(
                colorGradient: expenseColor,
                titleCard: 'Pengeluaran',
                budget: '2.000.000',
              ),
              Cardlaporanheader(
                colorGradient: mainColor,
                titleCard: 'Sisa',
                budget: '20.000.000',
              )
            ],
          ),
        )
      ],
    );
  }
}
