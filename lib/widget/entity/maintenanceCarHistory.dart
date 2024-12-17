import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:note_app_vtwo/settings/style_and_colors_utils.dart';
import 'package:note_app_vtwo/widget/dialog/dilaogEditDataLaporan.dart';
import 'package:note_app_vtwo/widget/dialog/dilaogPeringatanHapusData.dart';

class Maintenancecarhistory extends StatelessWidget {
  final String namaOnderdil;
  final String hargaOnderdil;
  final String tanggalInput;

  const Maintenancecarhistory(
      {super.key,
      required this.namaOnderdil,
      required this.hargaOnderdil,
      required this.tanggalInput});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 5),
      child: Container(
        width: double.maxFinite,
        height: MediaQuery.of(context).size.height * 0.098,
        decoration: BoxDecoration(
            color: secondaryColor,
            // border: Border.all(),
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
                    tanggalInput,
                    style: GoogleFonts.poppins(
                        color: mainColor,
                        fontSize: MediaQuery.sizeOf(context).height * 0.025,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    width: 40,
                  ),
                  PopupMenuButton(
                      color: secondaryColor,
                      icon: SvgPicture.asset(
                        'assets/triple dots icon.svg',
                        width: MediaQuery.sizeOf(context).width * 0.03,
                        height: MediaQuery.sizeOf(context).height * 0.03,
                      ),
                      itemBuilder: (BuildContext context) {
                        return [
                          PopupMenuItem(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 40, vertical: 10),
                              onTap: () {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return Dilaogeditdatalaporan();
                                    });
                              },
                              value: 'Edit',
                              child: Row(
                                children: [
                                  SvgPicture.asset('assets/edit icon.svg'),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    'Edit',
                                    style: GoogleFonts.poppins(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: mainColor),
                                  ),
                                ],
                              )),
                          PopupMenuItem(
                              onTap: () {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return Dialog(
                                        backgroundColor: Colors.transparent,
                                        child: Dilaogperingatanhapusdata(),
                                      );
                                    });
                              },
                              padding: EdgeInsets.symmetric(
                                  horizontal: 40, vertical: 10),
                              child: Row(
                                children: [
                                  SvgPicture.asset(
                                    'assets/delete icon.svg',
                                    color: mainColor,
                                    height: 30,
                                    width: 30,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    'Delete',
                                    style: GoogleFonts.poppins(
                                        color: mainColor,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ))
                        ];
                      }),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
