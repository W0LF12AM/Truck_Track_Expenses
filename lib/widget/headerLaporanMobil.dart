import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:note_app_vtwo/settings/style_and_colors_utils.dart';

class Headerlaporanmobil extends StatelessWidget {
  final int number;
  final String platnomor;
  final VoidCallback navigate;
  final String textButton;

  const Headerlaporanmobil(
      {super.key,
      required this.number,
      required this.platnomor,
      required this.navigate,
      required this.textButton});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 15,
      ),
      child: Container(
        height: 98,
        width: double.maxFinite,
        decoration: BoxDecoration(
            color: secondaryColor, borderRadius: BorderRadius.circular(10)),

        //Content Bar History
        child: Padding(
          padding: const EdgeInsets.only(left: 10, right: 30),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    width: 50,
                    height: 60,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: mainColor,
                    ),

                    //Number
                    child: Center(
                      child: Text(number.toString(),
                          style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontSize: 25,
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
                        fontSize: 30,
                        fontWeight: FontWeight.w700),
                  ),
                ],
              ),
              GestureDetector(
                  onTap: navigate,
                  child: Container(
                      width: 180,
                      height: 50,
                      decoration: BoxDecoration(
                          color: mainColor,
                          borderRadius: BorderRadius.circular(5)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                          child: Text(
                            textButton,
                            style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      )))
            ],
          ),
        ),
      ),
    );
  }
}
