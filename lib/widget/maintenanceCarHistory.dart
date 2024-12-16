import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:note_app_vtwo/settings/style_and_colors_utils.dart';

class Maintenancecarhistory extends StatelessWidget {
  const Maintenancecarhistory({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Container(
        width: double.maxFinite,
        height: 98,
        decoration: BoxDecoration(
            color: secondaryColor,
            border: Border.all(),
            borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  SvgPicture.asset('assets/fix icon.svg'),
                  const SizedBox(
                    width: 40,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Onderdil',
                        style: GoogleFonts.poppins(
                            color: mainColor,
                            fontSize: 25,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Rp. 1.200.000',
                        style: GoogleFonts.poppins(
                            color: mainColor,
                            fontSize: 30,
                            fontWeight: FontWeight.w500),
                      )
                    ],
                  )
                ],
              ),
              Row(
                children: [
                  Text(
                    'DD / MM / YYYY',
                    style: GoogleFonts.poppins(
                        color: mainColor,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    width: 40,
                  ),
                  SvgPicture.asset('assets/triple dots icon.svg')
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
