import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:note_app_vtwo/settings/style_and_colors_utils.dart';

class UserheaderCustomWithoutSearchbar extends StatelessWidget {
  const UserheaderCustomWithoutSearchbar(
      {super.key, required this.titlePage, required this.iconHeader});

  final String titlePage;
  final String iconHeader;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      height: 130,
      decoration: BoxDecoration(color: mainColor),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: Row(
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
      ),
    );
  }
}
