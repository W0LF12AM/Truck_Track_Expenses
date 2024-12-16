import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:note_app_vtwo/settings/style_and_colors_utils.dart';

class Maintenancecarhistory extends StatelessWidget {
  final String namaOnderdil;
  final String hargaOnderdil;

  const Maintenancecarhistory(
      {super.key, required this.namaOnderdil, required this.hargaOnderdil});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Container(
        width: double.maxFinite,
        height: MediaQuery.of(context).size.height * 0.098,
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
                  SvgPicture.asset(
                    'assets/fix icon.svg',
                    width: MediaQuery.of(context).size.width * 0.03,
                    height: MediaQuery.of(context).size.height * 0.05,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.02,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        namaOnderdil,
                        style: GoogleFonts.poppins(
                            color: mainColor,
                            fontSize:
                                MediaQuery.of(context).size.height * 0.025,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Rp. $hargaOnderdil',
                        style: GoogleFonts.poppins(
                            color: mainColor,
                            fontSize: MediaQuery.of(context).size.height * 0.03,
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
                  SvgPicture.asset(
                    'assets/triple dots icon.svg',
                    width: MediaQuery.sizeOf(context).width * 0.03,
                    height: MediaQuery.sizeOf(context).height * 0.03,
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
