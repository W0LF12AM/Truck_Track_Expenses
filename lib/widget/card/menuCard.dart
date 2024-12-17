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
          width: MediaQuery.of(context).size.width * 0.15,
          height: MediaQuery.of(context).size.height * 0.35,
          decoration: BoxDecoration(
              color: secondaryColor, borderRadius: BorderRadius.circular(10)),
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              children: [
                //icon
                Row(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.038,
                      height: MediaQuery.of(context).size.height * 0.07,
                      decoration: BoxDecoration(
                          color: mainColor,
                          borderRadius: BorderRadius.circular(5)),
                      child: Padding(
                        padding: EdgeInsets.all(
                            MediaQuery.of(context).size.width * 0.007),
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
                          fontSize: MediaQuery.of(context).size.height * 0.032,
                          fontWeight: FontWeight.w700),
                    ),
                  ],
                ),
                SizedBox(
                  height: MediaQuery.sizeOf(context).height * 0.001,
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
                  height: MediaQuery.of(context).size.height * 0.008,
                ),
                Text(
                  description,
                  style: GoogleFonts.poppins(
                      color: mainColor,
                      fontSize: MediaQuery.of(context).size.width * 0.009,
                      fontWeight: FontWeight.w700),
                ),
                //arrow button
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.001,
                ),
                GestureDetector(
                  onTap: navigate,
                  child: Align(
                      alignment: Alignment.centerRight,
                      child: SvgPicture.asset(
                        'assets/arrow icon.svg',
                        width: MediaQuery.of(context).size.width * 0.0265,
                        height: MediaQuery.of(context).size.width * 0.0265,
                      )),
                )
              ],
            ),
          ),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.02,
        )
      ],
    );
  }
}
