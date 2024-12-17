import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:note_app_vtwo/settings/style_and_colors_utils.dart';

class Dialogdatadisimpan extends StatelessWidget {
  final String titleCard;
  final String pesan;

  const Dialogdatadisimpan(
      {super.key, required this.titleCard, required this.pesan});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 600,
      height: 300,
      child: Stack(
        children: [
          Center(
            child: Container(
              width: 500,
              height: 250,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: secondaryColor),
              child: Padding(
                padding: EdgeInsets.symmetric(
                    vertical: MediaQuery.sizeOf(context).height * 0.025),
                child: Column(
                  children: [
                    Text(
                      titleCard,
                      style: GoogleFonts.poppins(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: mainColor),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: MediaQuery.sizeOf(context).width * 0.05),
                      child: Divider(
                        thickness: 4,
                        color: mainColor,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      textAlign: TextAlign.center,
                      pesan,
                      style: GoogleFonts.poppins(
                          color: Colors.black, fontSize: 15),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                            width: 250,
                            height: 45,
                            decoration: BoxDecoration(
                                color: mainColor,
                                borderRadius: BorderRadius.circular(5)),
                            child: Center(
                              child: Text(
                                'Lanjutkan',
                                style: GoogleFonts.poppins(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
                                    color: secondaryColor),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
              top: 5,
              left: 25,
              child: SvgPicture.asset(
                'assets/check dialog icon.svg',
                width: 60,
                height: 60,
              ))
        ],
      ),
    );
  }
}
