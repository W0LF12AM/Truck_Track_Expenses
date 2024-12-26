// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:excel/excel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:note_app_vtwo/data/databaseHelper.dart';
import 'package:note_app_vtwo/data/model.dart';
import 'package:note_app_vtwo/function/provider.dart';
import 'package:note_app_vtwo/settings/style_and_colors_utils.dart';
import 'package:note_app_vtwo/widget/card/cardLaporanHeader.dart';
import 'package:note_app_vtwo/widget/header/headerLaporanMobil.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

class UserheaderLaporanDetail extends StatefulWidget {
  UserheaderLaporanDetail(
      {super.key,
      required this.titlePage,
      required this.iconHeader,
      required this.nomor,
      required this.platNomor,
      required this.budget,
      required this.expense,
      required this.sisaBudget,
      required this.truckId});

  final String titlePage;
  final String iconHeader;
  int nomor;
  final String platNomor;
  final String budget;
  final String expense;
  final String sisaBudget;
  final int truckId;

  @override
  State<UserheaderLaporanDetail> createState() =>
      _UserheaderLaporanDetailState();
}

class _UserheaderLaporanDetailState extends State<UserheaderLaporanDetail> {
  Future<void> saveTruckExpensesToExcel(int truckId) async {
    final truckProvider = Provider.of<TruckProvider>(context, listen: false);

    await truckProvider.loadExpensesByTruckId(truckId);

    Truck selectedTruck = truckProvider.trucks.firstWhere(
        (t) => t.id == truckId,
        orElse: () => Truck(
            id: -1,
            platNomor: 'Tidak Ditemukan',
            budgetTahunan: 0.0,
            number: 0));

    if (selectedTruck.id == -1) {
      print('Truk tidak ditemukan');
      return;
    }

    List<Expense> expenses = truckProvider.expenses;

    var excel = Excel.createExcel();
    Sheet sheet = excel['Sheet1'];

    // Tambahkan header
    sheet.appendRow([
      TextCellValue('Plat Nomor'),
      TextCellValue('Bulan'),
      TextCellValue('Tanggal Input'),
      TextCellValue('Onderdil'),
      TextCellValue('Harga'),
    ]);

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
      sheet.appendRow([
        TextCellValue(selectedTruck.platNomor),
        TextCellValue(month),
        TextCellValue(expense.date.toIso8601String()),
        TextCellValue(expense.onderdil),
        DoubleCellValue(expense.harga),
      ]);
    }

    sheet.appendRow([
      TextCellValue(''),
      TextCellValue(''),
    ]);

    sheet.appendRow([
      TextCellValue('Total Pengeluaran: ${truckProvider.getTotalExpense()}'),
      TextCellValue('Budget: ${selectedTruck.budgetTahunan}'),
      TextCellValue('Sisa Budget: ${truckProvider.getRemainingBudget(truckId)}')
    ]);

    final directory = await getApplicationDocumentsDirectory();
    final downloadDirectory =
        Directory('${directory!.path}/Downloaded Truck Data');

    if (!await downloadDirectory.exists()) {
      await downloadDirectory.create(recursive: true);
    }

    String fileName = '${selectedTruck.platNomor}_expenses.xlsx';

    final filePath = '${downloadDirectory.path}/$fileName';
    final file = File(filePath);
    if (await file.exists()) {
      await file.delete(); // Hapus file yang sudah ada
    }

    await file.writeAsBytes(await excel.encode() ?? []);

    print('File saved at $filePath');
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.maxFinite,
          height: MediaQuery.of(context).size.height * 0.36,
          decoration: BoxDecoration(color: mainColor),
          child: Padding(
            padding: const EdgeInsets.only(left: 40, right: 40, top: 40),
            child: Column(
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
                      widget.titlePage,
                      style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: MediaQuery.of(context).size.width * 0.017,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                SizedBox(
                  height: MediaQuery.sizeOf(context).height * 0.025,
                ),
                Headerlaporanmobil(
                    platnomor: widget.platNomor,
                    navigate: () {
                      saveTruckExpensesToExcel(widget.truckId);
                    },
                    textButton: 'Download')
              ],
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
              top: MediaQuery.of(context).size.height * 0.28,
              left: 40,
              right: 40),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Cardlaporanheader(
                colorGradient: budgetColor,
                titleCard: 'Budget',
                budget: widget.budget,
              ),
              Cardlaporanheader(
                colorGradient: expenseColor,
                titleCard: 'Pengeluaran',
                budget: widget.expense,
              ),
              Cardlaporanheader(
                colorGradient: mainColor,
                titleCard: 'Sisa',
                budget: widget.sisaBudget,
              )
            ],
          ),
        )
      ],
    );
  }
}
