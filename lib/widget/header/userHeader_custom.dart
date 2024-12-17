import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:note_app_vtwo/settings/style_and_colors_utils.dart';

class UserheaderCustom extends StatefulWidget {
  final String iconHeader;
  final String titleHeader;
  const UserheaderCustom(
      {super.key, required this.iconHeader, required this.titleHeader});

  @override
  State<UserheaderCustom> createState() => _UserheaderCustomState();
}

class _UserheaderCustomState extends State<UserheaderCustom> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      height: MediaQuery.of(context).size.height * 0.13,
      decoration: BoxDecoration(color: mainColor),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                SvgPicture.asset(
                  widget.iconHeader,
                  color: secondaryColor,
                  width: MediaQuery.of(context).size.width * 0.05,
                  height: MediaQuery.of(context).size.height * 0.05,
                ),
                const SizedBox(
                  width: 20,
                ),
                Text(
                  widget.titleHeader,
                  style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: MediaQuery.of(context).size.width * 0.017,
                      fontWeight: FontWeight.bold),
                )
              ],
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.17,
              height: MediaQuery.of(context).size.height * 0.05,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(10)),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: TextField(
                  style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w700, fontSize: 20),
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Search',
                      hintStyle: TextStyle(fontSize: 20),
                      prefixIcon: Icon(Icons.search)),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
