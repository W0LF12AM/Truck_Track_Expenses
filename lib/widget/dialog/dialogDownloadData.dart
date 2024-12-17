import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:note_app_vtwo/settings/style_and_colors_utils.dart';

class Dialogdownloaddata extends StatelessWidget {
  const Dialogdownloaddata({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        padding: EdgeInsets.all(20),
        width: MediaQuery.sizeOf(context).width * 0.22,
        height: MediaQuery.sizeOf(context).height * 0.28,
        decoration: BoxDecoration(
            color: secondaryColor, borderRadius: BorderRadius.circular(5)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Unduh Data',
              style: GoogleFonts.poppins(
                  fontSize: 30, color: mainColor, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: MediaQuery.sizeOf(context).height * 0.01,
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
            Container(
                width: MediaQuery.sizeOf(context).width * 0.2,
                height: MediaQuery.sizeOf(context).height * 0.05,
                decoration: BoxDecoration(color: formColor),
                child: TextField(
                  style: GoogleFonts.poppins(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: mainColor),
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Tahun',
                      hintStyle: GoogleFonts.poppins(
                          fontSize: 20, fontWeight: FontWeight.bold),
                      contentPadding: EdgeInsets.only(left: 10, top: 5),
                      suffixIcon: Icon(
                        Icons.arrow_drop_down,
                        size: 50,
                      )),
                )),
            SizedBox(
              height: MediaQuery.sizeOf(context).height * 0.02,
            ),
            GestureDetector(
              onTap: () {},
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
