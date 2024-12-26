import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:note_app_vtwo/settings/style_and_colors_utils.dart';

class Dialogdownloaddata extends StatelessWidget {
  VoidCallback download;
  Dialogdownloaddata({super.key, required this.download});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        padding: EdgeInsets.all(20),
        width: MediaQuery.sizeOf(context).width * 0.22,
        height: MediaQuery.sizeOf(context).height * 0.23,
        decoration: BoxDecoration(
            color: secondaryColor, borderRadius: BorderRadius.circular(5)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Unduh Data',
              style: GoogleFonts.poppins(
                  fontSize: MediaQuery.sizeOf(context).width * 0.02,
                  color: mainColor,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: MediaQuery.sizeOf(context).height * 0.005,
            ),
            Padding(
              padding: EdgeInsets.only(
                  right: MediaQuery.sizeOf(context).width * 0.15),
              child: const Divider(
                color: mainColor,
                thickness: 4,
              ),
            ),
            SizedBox(
              height: MediaQuery.sizeOf(context).height * 0.01,
            ),
            Text(
              'Unduh semua data truck?',
              style: GoogleFonts.poppins(
                  fontSize: MediaQuery.sizeOf(context).width * 0.01,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: MediaQuery.sizeOf(context).height * 0.02,
            ),
            GestureDetector(
              onTap: download,
              child: Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.05,
                    width: MediaQuery.of(context).size.width * 0.07,
                    decoration: BoxDecoration(
                        color: mainColor,
                        borderRadius: BorderRadius.circular(5)),
                    child: Center(
                      child: Text(
                        'Download',
                        style: GoogleFonts.poppins(
                            color: secondaryColor,
                            fontSize: MediaQuery.of(context).size.width * 0.01,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  )),
            )
          ],
        ),
      ),
    );
  }
}
