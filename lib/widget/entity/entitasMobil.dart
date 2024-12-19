import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:note_app_vtwo/settings/style_and_colors_utils.dart';

class Entitasmobil extends StatefulWidget {
  final int id;
  final int number;
  final String platnomor;
  final VoidCallback deleteEntity;

  const Entitasmobil({
    super.key,
    required this.number,
    required this.platnomor,
    required this.deleteEntity,
    required this.id,
  });

  @override
  State<Entitasmobil> createState() => _EntitasmobilState();
}

class _EntitasmobilState extends State<Entitasmobil> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15, left: 30, right: 30),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.09,
        width: double.maxFinite,
        decoration: BoxDecoration(
            color: secondaryColor, borderRadius: BorderRadius.circular(15)),

        //Content Bar History
        child: Padding(
          padding: const EdgeInsets.only(left: 10, right: 30),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.027,
                    height: MediaQuery.of(context).size.height * 0.055,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: mainColor,
                    ),

                    //Number
                    child: Center(
                      child: Text(widget.number.toString(),
                          style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.012,
                              fontWeight: FontWeight.w600)),
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  ),

                  //Plat Nomor
                  Text(
                    widget.platnomor,
                    style: GoogleFonts.poppins(
                        color: mainColor,
                        fontSize: MediaQuery.of(context).size.width * 0.015,
                        fontWeight: FontWeight.w700),
                  ),
                ],
              ),
              GestureDetector(
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return Dialog(
                          backgroundColor: Colors.transparent,
                          child: Container(
                            width: 600,
                            height: 300,
                            child: Stack(
                              children: [
                                Center(
                                  child: Container(
                                    width: 500,
                                    height: 250,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: secondaryColor),
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical: MediaQuery.sizeOf(context)
                                                  .height *
                                              0.025),
                                      child: Column(
                                        children: [
                                          Text(
                                            'Hapus Data',
                                            style: GoogleFonts.poppins(
                                                fontSize: 30,
                                                fontWeight: FontWeight.bold,
                                                color: mainColor),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal:
                                                    MediaQuery.sizeOf(context)
                                                            .width *
                                                        0.05),
                                            child: Divider(
                                              thickness: 4,
                                              color: mainColor,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            textAlign: TextAlign.center,
                                            'Apakah kamu yakin ingin \nmenghapus data tersebut?',
                                            style: GoogleFonts.poppins(
                                                color: Colors.black,
                                                fontSize: 15),
                                          ),
                                          SizedBox(
                                            height: 25,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              GestureDetector(
                                                onTap: () {
                                                  widget.deleteEntity();
                                                  Navigator.pop(context);
                                                },
                                                child: Container(
                                                  width: 120,
                                                  height: 45,
                                                  decoration: BoxDecoration(
                                                      color: secondaryColor,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5),
                                                      border: Border.all(
                                                          color: mainColor,
                                                          width: 3)),
                                                  child: Center(
                                                    child: Text(
                                                      'Hapus',
                                                      style: GoogleFonts.poppins(
                                                          color: mainColor,
                                                          fontSize:
                                                              MediaQuery.sizeOf(
                                                                          context)
                                                                      .width *
                                                                  0.012,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                width:
                                                    MediaQuery.sizeOf(context)
                                                            .width *
                                                        0.005,
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  Navigator.pop(context);
                                                },
                                                child: Container(
                                                  width: 120,
                                                  height: 45,
                                                  decoration: BoxDecoration(
                                                      color: mainColor,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5)),
                                                  child: Center(
                                                    child: Text(
                                                      'Batal',
                                                      style: GoogleFonts.poppins(
                                                          fontSize: 25,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          color:
                                                              secondaryColor),
                                                    ),
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                    top: 5,
                                    left: 25,
                                    child: SvgPicture.asset(
                                      'assets/cancel dialog icon.svg',
                                      width: 60,
                                      height: 60,
                                    ))
                              ],
                            ),
                          ),

                          // widget.deleteEntity;
                        );
                      });
                },
                child: Container(
                    padding: EdgeInsets.all(8),
                    width: MediaQuery.of(context).size.width * 0.03,
                    height: MediaQuery.of(context).size.height * 0.05,
                    decoration: BoxDecoration(
                        color: mainColor,
                        borderRadius: BorderRadius.circular(5)),
                    child: SvgPicture.asset(
                      'assets/delete icon.svg',
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
