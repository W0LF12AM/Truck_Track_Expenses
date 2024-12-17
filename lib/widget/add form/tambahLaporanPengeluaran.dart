import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:note_app_vtwo/settings/style_and_colors_utils.dart';

class Tambahlaporanpengeluaran extends StatefulWidget {
  const Tambahlaporanpengeluaran({super.key});

  @override
  State<Tambahlaporanpengeluaran> createState() =>
      _TambahlaporanpengeluaranState();
}

class _TambahlaporanpengeluaranState extends State<Tambahlaporanpengeluaran> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      backgroundColor: secondaryColor,
      child: Container(
        width: MediaQuery.sizeOf(context).width * 0.45,
        height: MediaQuery.sizeOf(context).height * 0.45,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Tambah Data',
                style: GoogleFonts.poppins(
                    color: mainColor,
                    fontSize: MediaQuery.sizeOf(context).width * 0.017,
                    fontWeight: FontWeight.bold),
              ),
              Padding(
                padding: EdgeInsets.only(
                    right: MediaQuery.sizeOf(context).width * 0.35),
                child: Divider(
                  color: mainColor,
                  thickness: 3,
                ),
              ),
              SizedBox(
                height: MediaQuery.sizeOf(context).height * 0.03,
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: formColor,
                ),
                height: MediaQuery.sizeOf(context).height * 0.06,
                child: TextField(
                  textAlign: TextAlign.start,
                  style: GoogleFonts.poppins(
                      fontWeight: FontWeight.bold, fontSize: 20),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Onderdil',
                    contentPadding: EdgeInsets.only(left: 10),
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.sizeOf(context).height * 0.02,
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: formColor,
                ),
                height: MediaQuery.sizeOf(context).height * 0.06,
                child: TextField(
                  textAlign: TextAlign.start,
                  style: GoogleFonts.poppins(
                      fontWeight: FontWeight.bold, fontSize: 20),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Harga',
                    contentPadding: EdgeInsets.only(left: 10),
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.sizeOf(context).height * 0.02,
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: formColor,
                ),
                height: MediaQuery.sizeOf(context).height * 0.06,
                child: TextField(
                  textAlign: TextAlign.start,
                  style: GoogleFonts.poppins(
                      fontWeight: FontWeight.bold, fontSize: 20),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Tanggal',
                    contentPadding: EdgeInsets.only(left: 10),
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.sizeOf(context).height * 0.03,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      width: MediaQuery.sizeOf(context).width * 0.048,
                      height: MediaQuery.sizeOf(context).height * 0.048,
                      decoration: BoxDecoration(
                          color: mainColor,
                          borderRadius: BorderRadius.circular(5)),
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: SvgPicture.asset(
                          'assets/cancel icon.svg',
                          color: secondaryColor,
                          width: MediaQuery.sizeOf(context).width * 0.03,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.sizeOf(context).width * 0.005,
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      width: MediaQuery.sizeOf(context).width * 0.048,
                      height: MediaQuery.sizeOf(context).height * 0.048,
                      decoration: BoxDecoration(
                          color: mainColor,
                          borderRadius: BorderRadius.circular(5)),
                      child: Icon(
                        Icons.check,
                        color: secondaryColor,
                        size: MediaQuery.sizeOf(context).width * 0.02,
                      ),
                    ),
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
