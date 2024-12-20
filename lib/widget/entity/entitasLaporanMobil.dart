import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:note_app_vtwo/data/model.dart';
import 'package:note_app_vtwo/settings/style_and_colors_utils.dart';

class EntitasLaporanMobil extends StatelessWidget {
  final int number;
  final String platnomor;
  final VoidCallback navigate;
  final String sisaBudget;
  final String tanggalInput;

  const EntitasLaporanMobil({
    super.key,
    required this.number,
    required this.platnomor,
    required this.navigate,
    required this.sisaBudget,
    required this.tanggalInput,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15, left: 30, right: 30),
      child: GestureDetector(
        onTap: navigate,
        child: Container(
          height: MediaQuery.of(context).size.height * 0.09,
          width: double.maxFinite,
          decoration: BoxDecoration(
              color: secondaryColor, borderRadius: BorderRadius.circular(15)),

          //Content Bar History
          child: Padding(
            padding: const EdgeInsets.only(left: 10, right: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.027,
                      height: MediaQuery.of(context).size.height * 0.055,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: mainColor,
                      ),

                      //Number
                      child: Center(
                        child: Text(number.toString(),
                            style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.012,
                                fontWeight: FontWeight.w600)),
                      ),
                    ),
                    SizedBox(
                      width: 15,
                    ),

                    //Plat Nomor
                    Text(
                      platnomor,
                      style: GoogleFonts.poppins(
                          color: mainColor,
                          fontSize: MediaQuery.of(context).size.width * 0.015,
                          fontWeight: FontWeight.w700),
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Row(
                      children: [
                        SvgPicture.asset('assets/wallet icon.svg'),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Rp. $sisaBudget',
                          style: GoogleFonts.poppins(
                              color: mainColor,
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.013,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                    Text(
                      tanggalInput,
                      style: GoogleFonts.poppins(
                          color: mainColor,
                          fontSize: MediaQuery.of(context).size.width * 0.01,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
