import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:note_app_vtwo/data/databaseHelper.dart';
import 'package:note_app_vtwo/settings/style_and_colors_utils.dart';
import 'package:note_app_vtwo/widget/dialog/dilaogEditDataLaporan.dart';

class Maintenancecarhistory extends StatefulWidget {
  final String namaOnderdil;
  final String hargaOnderdil;
  final String tanggalInput;
  final int expenseId;
  final Function onDelete;

  const Maintenancecarhistory(
      {super.key,
      required this.namaOnderdil,
      required this.hargaOnderdil,
      required this.tanggalInput,
      required this.expenseId,
      required this.onDelete});

  @override
  State<Maintenancecarhistory> createState() => _MaintenancecarhistoryState();
}

class _MaintenancecarhistoryState extends State<Maintenancecarhistory> {
  final DatabaseHelper _databasehelper = DatabaseHelper();

  void _confirmDelete(BuildContext context) {
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
                            vertical:
                                MediaQuery.sizeOf(context).height * 0.025),
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
                                      MediaQuery.sizeOf(context).width * 0.05),
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
                                  color: Colors.black, fontSize: 15),
                            ),
                            SizedBox(
                              height: 25,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                GestureDetector(
                                  onTap: () async {
                                    await DatabaseHelper()
                                        .deleteExpense(widget.expenseId);
                                    Navigator.pop(context);
                                    widget.onDelete();
                                  },
                                  child: Container(
                                    width: 120,
                                    height: 45,
                                    decoration: BoxDecoration(
                                        color: secondaryColor,
                                        borderRadius: BorderRadius.circular(5),
                                        border: Border.all(
                                            color: mainColor, width: 3)),
                                    child: Center(
                                      child: Text(
                                        'Hapus',
                                        style: GoogleFonts.poppins(
                                            color: mainColor,
                                            fontSize: MediaQuery.sizeOf(context)
                                                    .width *
                                                0.012,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width:
                                      MediaQuery.sizeOf(context).width * 0.005,
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
                                        borderRadius: BorderRadius.circular(5)),
                                    child: Center(
                                      child: Text(
                                        'Batal',
                                        style: GoogleFonts.poppins(
                                            fontSize: 25,
                                            fontWeight: FontWeight.w500,
                                            color: secondaryColor),
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
  }

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
                        widget.namaOnderdil,
                        style: GoogleFonts.poppins(
                            color: mainColor,
                            fontSize:
                                MediaQuery.of(context).size.height * 0.025,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        '${widget.hargaOnderdil}',
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
                    widget.tanggalInput,
                    style: GoogleFonts.poppins(
                        color: mainColor,
                        fontSize: MediaQuery.sizeOf(context).height * 0.025,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    width: 40,
                  ),
                  GestureDetector(
                    onTap: () {
                      _confirmDelete(context);
                    },
                    child: Container(
                      padding: EdgeInsets.all(
                          MediaQuery.sizeOf(context).width * 0.004),
                      width: MediaQuery.sizeOf(context).width * 0.025,
                      height: MediaQuery.sizeOf(context).height * 0.045,
                      decoration: BoxDecoration(
                          color: mainColor,
                          borderRadius: BorderRadius.circular(5)),
                      child: SvgPicture.asset(
                        'assets/delete icon.svg',
                        // width: MediaQuery.sizeOf(context).width * 0.03,
                        // height: MediaQuery.sizeOf(context).height * 0.03,
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
