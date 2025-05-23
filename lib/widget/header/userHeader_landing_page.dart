import 'dart:io';

import 'package:excel/excel.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:note_app_vtwo/data/databaseHelper.dart';
import 'package:note_app_vtwo/data/model.dart';
import 'package:note_app_vtwo/function/provider.dart';
import 'package:note_app_vtwo/settings/style_and_colors_utils.dart';
import 'package:note_app_vtwo/widget/dialog/dialogDataDisimpan.dart';
import 'package:note_app_vtwo/widget/dialog/dialogDownloadData.dart';
import 'package:note_app_vtwo/widget/dialog/dialogResetData.dart';
import 'package:note_app_vtwo/widget/card/menuCard.dart';
import 'package:note_app_vtwo/widget/card/menuCard_download_dan_reset.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

class UserheaderLandingPage extends StatefulWidget {
  final Function(int) onItemTapped;

  UserheaderLandingPage({super.key, required this.onItemTapped});

  @override
  State<UserheaderLandingPage> createState() => _UserheaderLandingPageState();
}

class _UserheaderLandingPageState extends State<UserheaderLandingPage> {
  Future<String?> saveAllTrucksExpensesToExcel() async {
    final truckProvider = Provider.of<TruckProvider>(context, listen: false);

    await truckProvider.loadTrucks();

    var excel = Excel.createExcel();

    List<Truck> trucks = truckProvider.trucks;

    String? outputDir;

    for (var truck in trucks) {
      Sheet sheet = excel[truck.platNomor];
      sheet.appendRow([
        TextCellValue('Plat Nomor'),
        TextCellValue('Bulan'),
        TextCellValue('Tanggal Input'),
        TextCellValue('Waktu'),
        TextCellValue('Onderdil'),
        TextCellValue('Harga')
      ]);

      List<Expense> expenses =
          await truckProvider.loadExpensesByTruckId(truck.id);

      for (var expense in expenses) {
        String month = [
          'Janurai',
          'Februari',
          'Maret',
          'April',
          'Mei',
          'Juni',
          'Juli',
          'Agustus',
          'September',
          'Oktober',
          'November',
          'Desember'
        ][expense.date.month - 1];

        String timeFormatted = '${expense.time.hour}:${expense.time.minute}';
        sheet.appendRow([
          TextCellValue(truck.platNomor),
          TextCellValue(month),
          TextCellValue(expense.date.toIso8601String()),
          TextCellValue(timeFormatted),
          TextCellValue(expense.onderdil),
          TextCellValue(
              'Rp ${expense.harga.toString().replaceAllMapped(RegExp(r'(\d)(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.')}')
        ]);
      }

      sheet.appendRow([TextCellValue(''), TextCellValue('')]);

      double totalExpense = truckProvider.getTotalExpense();
      double remainingBudget = truckProvider.getRemainingBudget(truck.id);

      sheet.appendRow([
        TextCellValue(
            'Total Pengeluaran: Rp ${totalExpense.toString().replaceAllMapped(RegExp(r'(\d)(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.')}'),
        TextCellValue(
            'Budget: Rp ${truck.budgetTahunan.toString().replaceAllMapped(RegExp(r'(\d)(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.')}'),
        TextCellValue(
            'Sisa Budget: Rp ${remainingBudget.toString().replaceAllMapped(RegExp(r'(\d)(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.')}'),
      ]);
    }

    // final directory = await getApplicationDocumentsDirectory();
    // final downloadDirectory =
    //     Directory('${directory.path}/Downloaded Truck Data');

    // if (!await downloadDirectory.exists()) {
    //   await downloadDirectory.create(recursive: true);
    // }

    // String baseFileName = 'all trucks expenses.xlsx';
    // String filePath = '${downloadDirectory.path}/$baseFileName';
    // var file = File(filePath);

    // int copyKe = 1;

    // while (await file.exists()) {
    //   copyKe++;
    //   filePath = '${downloadDirectory.path}/copy $copyKe of $baseFileName';
    //   file = File(filePath);
    // }

    try {
      outputDir = await FilePicker.platform.getDirectoryPath();
    } catch (e) {
      print('Error memilih folder: $e');
      return 'Gagal memilih folder';
    }

    if (outputDir == null) {
      return null;
    }

    String baseFileName = 'all_trucks_expenses.xlsx';
    String filePath = '$outputDir/$baseFileName';
    var file = File(filePath);

    int copyIndex = 1;
    while (file.existsSync()) {
      filePath = '$outputDir/all_trucks_expenses_copy_$copyIndex.xlsx';
      file = File(filePath);
      copyIndex++;
    }

    await file.writeAsBytes(await excel.encode() ?? []);

    print('File saved at $filePath');
    return filePath;
  }

  Future<void> resetAllData() async {
    final truckProvider = Provider.of<TruckProvider>(context, listen: false);
    await truckProvider.resetExpensesAndBudget();
  }

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    String greetings;

    if (now.hour < 12) {
      greetings = 'Good Morning';
    } else if (now.hour < 18) {
      greetings = 'Good Afternoon';
    } else {
      greetings = 'Good Evening';
    }

    String formatDate = DateFormat('EEEE,  dd MMMM yyyy').format(now);

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
                      Text('$greetings Sir!',
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
                            width: MediaQuery.sizeOf(context).width * 0.0085,
                          ),
                          Text(
                            formatDate,
                            style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontSize:
                                    MediaQuery.sizeOf(context).height * 0.02,
                                fontWeight: FontWeight.normal),
                          ),
                          SizedBox(
                            width: MediaQuery.sizeOf(context).width * 0.01,
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
              navigate: () async {
                String? filePath = await saveAllTrucksExpensesToExcel();

                if (filePath == null || filePath.isEmpty) {
                  return null;
                }

                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return Dialog(
                        backgroundColor: Colors.transparent,
                        child: Dialogdatadisimpan(
                            titleCard: 'Berhasil Mengunduh Data',
                            pesan:
                                'Data berhasil diunduh pada folder: $filePath'),
                      );
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
                        child: Dialogresetdata(
                          restart: () async {
                            await resetAllData();
                            await Provider.of<TruckProvider>(context,
                                    listen: false)
                                .loadMonthlyMaintenanceData();
                            Navigator.pop(context);
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return Dialog(
                                      backgroundColor: Colors.transparent,
                                      child: Dialogdatadisimpan(
                                          titleCard: 'Data berhasil direset',
                                          pesan:
                                              'Semua data berhasil dihapus'));
                                });
                          },
                        ),
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
