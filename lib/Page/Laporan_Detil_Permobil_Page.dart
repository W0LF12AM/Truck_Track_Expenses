// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:note_app_vtwo/data/databaseHelper.dart';
import 'package:note_app_vtwo/data/model.dart';
import 'package:note_app_vtwo/settings/style_and_colors_utils.dart';
import 'package:note_app_vtwo/widget/entity/maintenanceCarHistory.dart';
import 'package:note_app_vtwo/widget/add%20form/tambahLaporanPengeluaran.dart';
import 'package:note_app_vtwo/widget/header/userHeader_laporan_detail.dart';

class LaporanDetilPermobilPage extends StatefulWidget {
  final Function(int) onItemTapped;
  final int truckId;
  final Function goBack;

  LaporanDetilPermobilPage(
      {super.key,
      required this.onItemTapped,
      required this.truckId,
      required this.goBack});

  @override
  State<LaporanDetilPermobilPage> createState() =>
      _LaporanDetilPermobilPageState();
}

class _LaporanDetilPermobilPageState extends State<LaporanDetilPermobilPage> {
  final DatabaseHelper _databasehelper = DatabaseHelper();
  Truck? _selectedTruckId;
  List<Expense> _expense = [];

  @override
  void initState() {
    super.initState();
    print('initState dipanggil');
    print('ID truk yang diterima: ${widget.truckId}');
    if (widget.truckId != 0) {
      _loadTruckData(widget.truckId);
    } else {
      print('ID truk tidak valid, tidak memuat data.');
    }
    //_loadTruckData(widget.truckId);
  }

  @override
  void didUpdateWidget(LaporanDetilPermobilPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.truckId != widget.truckId) {
      print("ID truk yang diperbaharui : ${widget.truckId}");
      _loadTruckData(widget.truckId);
    }
  }

  Future<void> _loadTruckData(int id) async {
    print('Mencoba memuat data untuk ID: $id');
    try {
      _selectedTruckId = await _databasehelper.getTruckById(id);
      print('truk data berhasil di load : $_selectedTruckId');
    } catch (e) {
      print('gagal cuy');
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (_selectedTruckId == null) {
      return Center(child: CircularProgressIndicator());
    }

    String formatBudget = NumberFormat.currency(locale: 'id_ID', symbol: 'Rp. ')
        .format(_selectedTruckId!.budgetTahunan);
    String formatExpense =
        NumberFormat.currency(locale: 'id_ID', symbol: 'Rp. ')
            .format(_selectedTruckId!.totalExpense);
    String formatSisaBudget =
        NumberFormat.currency(locale: "id_ID", symbol: 'Rp. ')
            .format(_selectedTruckId!.remainingBudget);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
    return Scaffold(
      backgroundColor: bgColor,
      body: Row(
        children: [
          Expanded(
            child: Column(
              children: [
                UserheaderLaporanDetail(
                  titlePage: 'Laporan Detail',
                  iconHeader: 'assets/report icon.svg',
                  nomor: _selectedTruckId?.id ?? 0,
                  platNomor: _selectedTruckId?.platNomor ?? 'Loading...',
                  budget: formatBudget,
                  expense: formatExpense,
                  sisaBudget: formatSisaBudget,
                ),
                SizedBox(
                  height: 20,
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                        children: _expense.map((expense) {
                      return Maintenancecarhistory(
                        namaOnderdil: expense.onderdil,
                        hargaOnderdil: NumberFormat.currency(
                                locale: 'id_ID',
                                symbol: 'Rp. ',
                                decimalDigits: 0)
                            .format(expense.harga),
                        tanggalInput:
                            DateFormat('dd / MM / yyyy').format(expense.date),
                      );
                    }).toList()),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
      floatingActionButton: Container(
        decoration: BoxDecoration(
            border: Border.all(width: 2),
            borderRadius: BorderRadius.circular(15)),
        width: 70,
        height: 70,
        child: FloatingActionButton(
          backgroundColor: secondaryColor,
          onPressed: () async {
            final newExpense = await showDialog(
                context: context,
                builder: (BuildContext context) {
                  return Tambahlaporanpengeluaran(
                    truck: _selectedTruckId!,
                  );
                });

            if (newExpense != null) {
              setState(() {
                _expense.add(newExpense);
              });
            }
          },
          child: Container(
            child: Icon(
              Icons.add,
              color: mainColor,
              size: 50,
            ),
          ),
        ),
      ),
    );
  }
}
