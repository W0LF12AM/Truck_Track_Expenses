import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:note_app_vtwo/settings/style_and_colors_utils.dart';

class UserheaderCustom extends StatefulWidget {
  const UserheaderCustom({super.key, required this.iconHeader});

  final String iconHeader;

  @override
  State<UserheaderCustom> createState() => _UserheaderCustomState();
}

class _UserheaderCustomState extends State<UserheaderCustom> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      height: 130,
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
                  width: 50,
                  height: 50,
                ),
                const SizedBox(
                  width: 20,
                ),
                Text(
                  'Kelola Mobil',
                  style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.bold),
                )
              ],
            ),
            Container(
              width: 300,
              height: 50,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(10)),
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Search',
                        hintStyle: TextStyle(fontSize: 20),
                        prefixIcon: Icon(Icons.search)),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
