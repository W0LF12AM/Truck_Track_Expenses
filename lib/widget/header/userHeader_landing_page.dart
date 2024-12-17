import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:note_app_vtwo/settings/style_and_colors_utils.dart';
import 'package:note_app_vtwo/widget/dialog/dialogDownloadData.dart';
import 'package:note_app_vtwo/widget/dialog/dialogResetData.dart';
import 'package:note_app_vtwo/widget/card/menuCard.dart';
import 'package:note_app_vtwo/widget/card/menuCard_download_dan_reset.dart';

class UserheaderLandingPage extends StatefulWidget {
  final Function(int) onItemTapped;

  UserheaderLandingPage({super.key, required this.onItemTapped});

  @override
  State<UserheaderLandingPage> createState() => _UserheaderLandingPageState();
}

class _UserheaderLandingPageState extends State<UserheaderLandingPage> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.maxFinite,
          height: MediaQuery.sizeOf(context).height * 0.3,
          decoration: const BoxDecoration(color: mainColor),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50),
            child: Padding(
              padding: const EdgeInsets.only(top: 60),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Good Evening Sir!',
                          style: GoogleFonts.poppins(
                              fontSize:
                                  MediaQuery.sizeOf(context).height * 0.05,
                              fontWeight: FontWeight.w600,
                              color: Colors.white)),
                      Text(
                        'Hope you always have a great day',
                        style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: MediaQuery.sizeOf(context).height * 0.02,
                            fontWeight: FontWeight.w400),
                      )
                    ],
                  ),
                  Column(
                    children: [
                      Row(
                        children: [
                          SvgPicture.asset(
                            'assets/calendar icon.svg',
                            width: MediaQuery.sizeOf(context).width * 0.03,
                            height: MediaQuery.sizeOf(context).height * 0.03,
                          ),
                          SizedBox(
                            width: MediaQuery.sizeOf(context).width * 0.015,
                          ),
                          Text(
                            'DD/MM/YYYY',
                            style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontSize:
                                    MediaQuery.sizeOf(context).height * 0.02,
                                fontWeight: FontWeight.normal),
                          ),
                          SizedBox(
                            width: MediaQuery.sizeOf(context).width * 0.02,
                          ),
                          SvgPicture.asset(
                            'assets/profile icon.svg',
                            width: MediaQuery.sizeOf(context).width * 0.05,
                            height: MediaQuery.sizeOf(context).height * 0.05,
                          )
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
              top: MediaQuery.of(context).size.height * 0.21,
              left: MediaQuery.of(context).size.width * 0.031),
          child: Row(children: [
            Menucard(
              iconMenu: 'assets/car icon.svg',
              titleMenu: 'Kelola \nMobil',
              description: 'Tambah entitas mobilmu disini',
              navigate: () {
                widget.onItemTapped(1);
              },
            ),
            Menucard(
              iconMenu: 'assets/report icon.svg',
              titleMenu: 'Laporan \nMobil',
              description: 'kelola laporan perawatanmu disini',
              navigate: () {
                widget.onItemTapped(2);
              },
            ),
            Menucard(
              iconMenu: 'assets/setting icon.svg',
              titleMenu: 'Kelola \nBudget',
              description: 'Kelola pembiayaanmu disini',
              navigate: () {
                widget.onItemTapped(3);
              },
            ),
            MenucardDownloadDanReset(
              iconMenu: 'assets/download icon.svg',
              titleMenu: 'Unduh\nPencatatan',
              description: 'Unduh data berdasarkan tahun',
              buttonColor: mainColor,
              buttonName: 'Download',
              navigate: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return Dialogdownloaddata();
                    });
              },
            ),
            MenucardDownloadDanReset(
              iconMenu: 'assets/reset icon.svg',
              titleMenu: 'Reset \nData',
              description: 'Hapus semua data yang ada',
              buttonColor: expenseColor,
              buttonName: 'Reset',
              navigate: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return Dialog(
                        backgroundColor: Colors.transparent,
                        child: Dialogresetdata(),
                      );
                    });
              },
            ),
          ]),
        )
      ],
    );
  }
}
