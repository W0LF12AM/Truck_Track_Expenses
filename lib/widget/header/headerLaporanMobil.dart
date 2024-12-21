import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:note_app_vtwo/settings/style_and_colors_utils.dart';

class Headerlaporanmobil extends StatelessWidget {
  final String platnomor;
  final VoidCallback navigate;
  final String textButton;

  const Headerlaporanmobil(
      {super.key,
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
        height: MediaQuery.of(context).size.height * 0.098,
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
                    width: MediaQuery.of(context).size.width * 0.027,
                    height: MediaQuery.of(context).size.height * 0.055,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: mainColor,
                    ),

                    //Number
                    child: Center(
                      child: SvgPicture.asset(
                        'assets/entity car icon.svg',
                        width: MediaQuery.sizeOf(context).width * 0.02,
                      ),
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
              GestureDetector(
                  onTap: navigate,
                  child: Container(
                      width: MediaQuery.of(context).size.width * 0.1,
                      height: MediaQuery.of(context).size.height * 0.055,
                      decoration: BoxDecoration(
                          color: mainColor,
                          borderRadius: BorderRadius.circular(5)),
                      child: Padding(
                        padding: EdgeInsets.all(
                            MediaQuery.sizeOf(context).width * 0.003),
                        child: Center(
                          child: Text(
                            textButton,
                            style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontSize:
                                    MediaQuery.sizeOf(context).width * 0.012,
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
