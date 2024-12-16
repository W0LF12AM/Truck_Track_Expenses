import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:note_app_vtwo/settings/style_and_colors_utils.dart';

class Menucard extends StatelessWidget {
  final String iconMenu;
  final VoidCallback navigate;
  final String description;
  final String titleMenu;

  const Menucard(
      {super.key,
      required this.iconMenu,
      required this.navigate,
      required this.description,
      required this.titleMenu});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 350,
          width: 288,
          decoration: BoxDecoration(
              color: secondaryColor, borderRadius: BorderRadius.circular(10)),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                //icon
                Row(
                  children: [
                    Container(
                      width: 70,
                      height: 70,
                      decoration: BoxDecoration(
                          color: mainColor,
                          borderRadius: BorderRadius.circular(5)),
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: SvgPicture.asset(
                          iconMenu,
                          color: secondaryColor,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                //judul
                Row(
                  children: [
                    Text(
                      titleMenu,
                      style: GoogleFonts.poppins(
                          color: mainColor,
                          fontSize: 32,
                          fontWeight: FontWeight.w700),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                //divider
                const Padding(
                  padding: EdgeInsets.only(right: 140),
                  child: Divider(
                    thickness: 3,
                    color: mainColor,
                  ),
                ),

                //keterangan
                SizedBox(
                  height: 10,
                ),
                Text(
                  description,
                  style: GoogleFonts.poppins(
                      color: mainColor,
                      fontSize: 18,
                      fontWeight: FontWeight.w700),
                ),
                //arrow button
                const SizedBox(
                  height: 5,
                ),
                GestureDetector(
                  onTap: navigate,
                  child: Align(
                      alignment: Alignment.centerRight,
                      child: SvgPicture.asset(
                        'assets/arrow icon.svg',
                        width: 50,
                        height: 50,
                      )),
                )
              ],
            ),
          ),
        ),
        const SizedBox(
          width: 60,
        )
      ],
    );
  }
}
