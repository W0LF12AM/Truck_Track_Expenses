// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:note_app_vtwo/data/databaseHelper.dart';
import 'package:note_app_vtwo/data/model.dart';
import 'package:note_app_vtwo/function/provider.dart';
import 'package:note_app_vtwo/settings/style_and_colors_utils.dart';
import 'package:note_app_vtwo/widget/entity/maintenanceCarHistory.dart';
import 'package:note_app_vtwo/widget/add%20form/tambahLaporanPengeluaran.dart';
import 'package:note_app_vtwo/widget/header/userHeader_laporan_detail.dart';
import 'package:provider/provider.dart';

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
    // print('initState dipanggil');
    // print('ID truk yang diterima: ${widget.truckId}');
    // if (widget.truckId != 0) {
    //   _loadTruckData(widget.truckId);
    //   _loadExpenses();
    // } else {
    //   print('ID truk tidak valid, tidak memuat data.');
    // }
    Provider.of<TruckProvider>(context, listen: false).loadTrucks();
    //_loadTruckData(widget.truckId);
  }

  @override
  void didUpdateWidget(LaporanDetilPermobilPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.truckId != widget.truckId) {
      print("ID truk yang diperbaharui : ${widget.truckId}");
      _loadTruckData(widget.truckId);
      _loadExpenses();
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

  Future<void> _loadExpenses() async {
    List<Expense> expenses =
        await _databasehelper.getExpensesByTruckId(widget.truckId);
    print("Expenses loaded: $expenses");
    for (var expense in expenses) {
      print(
          "Expense: ${expense.onderdil}, Harga: ${expense.harga}"); // Debugging
    }
    if (_selectedTruckId != null) {
      _selectedTruckId!.expenses = expenses;
    }
    setState(() {
      _expense = expenses;
    });
  }

  @override
  Widget build(BuildContext context) {
    final truckProvider = Provider.of<TruckProvider>(context);
    final selectedTruck = truckProvider.trucks.firstWhere(
        (truck) => truck.id == widget.truckId,
        orElse: () =>
            Truck(id: 0, platNomor: 'load..', number: 0, budgetTahunan: 0.0));

    if (_selectedTruckId == null) {
      return Center(child: CircularProgressIndicator());
    }


    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
    return Consumer<TruckProvider>(
      builder: (context, truckProvider, child) {
        final selectedTruck = truckProvider.trucks.firstWhere(
            (truck) => truck.id == widget.truckId,
            orElse: () => Truck(
                id: 0, platNomor: 'loading', number: 0, budgetTahunan: 0.0));
        if (selectedTruck.id == 0) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        String formatBudget =
            NumberFormat.currency(locale: 'id_ID', symbol: 'Rp. ')
                .format(selectedTruck.budgetTahunan);
        String formatExpense =
            NumberFormat.currency(locale: 'id_ID', symbol: 'Rp. ')
                .format(selectedTruck.totalExpense);
        String formatSisaBudget =
            NumberFormat.currency(locale: 'id_ID', symbol: 'Rp. ')
                .format(selectedTruck.remainingBudget);

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
                            children: selectedTruck.expenses.map((expense) {
                          return Maintenancecarhistory(
                            namaOnderdil: expense.onderdil,
                            hargaOnderdil: NumberFormat.currency(
                                    locale: 'id_ID',
                                    symbol: 'Rp. ',
                                    decimalDigits: 0)
                                .format(expense.harga),
                            tanggalInput: DateFormat('dd / MM / yyyy')
                                .format(expense.date),
                            expenseId: expense.id,
                            onDelete: () {
                              _loadExpenses();
                            },
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
                  // _loadExpenses();
                  // setState(() {
                  //   _expense.add(newExpense);
                  // });
                  await Provider.of<TruckProvider>(context, listen: false)
                      .addExpense(newExpense, selectedTruck.id);
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
      },
    );
  }
}
