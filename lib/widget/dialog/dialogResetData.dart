import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:note_app_vtwo/settings/style_and_colors_utils.dart';

class Dialogresetdata extends StatelessWidget {
  VoidCallback restart;

 Dialogresetdata({super.key, required this.restart});

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
                      'Reset Data',
                      style: GoogleFonts.poppins(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: mainColor),
                    ),
                    SizedBox(
                      height: MediaQuery.sizeOf(context).height * 0.01,
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
                      height: MediaQuery.sizeOf(context).height * 0.01,
                    ),
                    Text(
                      textAlign: TextAlign.center,
                      'Apakah kamu yakin ingin \nmenghapus semua data tersebut?',
                      style: GoogleFonts.poppins(
                          color: Colors.black, fontSize: 15),
                    ),
                    SizedBox(
                      height: MediaQuery.sizeOf(context).height * 0.025,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: restart,
                          child: Container(
                            width: MediaQuery.sizeOf(context).width * 0.07,
                            height: MediaQuery.sizeOf(context).height * 0.048,
                            decoration: BoxDecoration(
                                color: secondaryColor,
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(color: mainColor, width: 3)),
                            child: Center(
                              child: Text(
                                'Reset',
                                style: GoogleFonts.poppins(
                                    color: mainColor,
                                    fontSize: MediaQuery.sizeOf(context).width *
                                        0.012,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.sizeOf(context).width * 0.005,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                            width: MediaQuery.sizeOf(context).width * 0.07,
                            height: MediaQuery.sizeOf(context).height * 0.048,
                            decoration: BoxDecoration(
                                color: mainColor,
                                borderRadius: BorderRadius.circular(5)),
                            child: Center(
                              child: Text(
                                'Batal',
                                style: GoogleFonts.poppins(
                                    fontSize: MediaQuery.sizeOf(context).width *
                                        0.012,
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
                'assets/cancel dialog icon.svg',
                width: 60,
                height: 60,
              ))
        ],
      ),
    );
  }
}
