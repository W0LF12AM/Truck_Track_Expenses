import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:note_app_vtwo/settings/style_and_colors_utils.dart';

class Cardlaporanheader extends StatelessWidget {
  const Cardlaporanheader(
      {super.key,
      required this.colorGradient,
      required this.titleCard,
      required this.budget});

  final Color colorGradient;
  final String titleCard;
  final String budget;
  

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.22,
      width: MediaQuery.of(context).size.width * 0.28,
      decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [secondaryColor, secondaryColor, colorGradient]),
          borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              titleCard,
              style: GoogleFonts.poppins(
                  color: mainColor,
                  fontSize: MediaQuery.of(context).size.width * 0.018,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.005,
            ),
            Padding(
              padding: EdgeInsets.only(
                  right: MediaQuery.of(context).size.width * 0.14),
              child: Divider(
                color: mainColor,
                thickness: 5,
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.005,
            ),
            Text(
              '$budget',
              style: GoogleFonts.poppins(
                color: Colors.black,
                fontSize: MediaQuery.of(context).size.width * 0.023,
                fontWeight: FontWeight.bold,
              ),
            )
          ],
        ),
      ),
    );
  }
}
