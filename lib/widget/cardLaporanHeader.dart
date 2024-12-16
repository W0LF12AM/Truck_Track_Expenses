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
      height: 200,
      width: 550,
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
                  color: mainColor, fontSize: 30, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 350),
              child: Divider(
                color: mainColor,
                thickness: 5,
              ),
            ),
            Text(
              'Rp. $budget',
              style: GoogleFonts.poppins(
                color: Colors.black,
                fontSize: 40,
                fontWeight: FontWeight.bold,
              ),
            )
          ],
        ),
      ),
    );
  }
}
