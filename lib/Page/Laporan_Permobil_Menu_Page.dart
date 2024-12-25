import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:note_app_vtwo/data/databaseHelper.dart';
import 'package:note_app_vtwo/data/model.dart';
import 'package:note_app_vtwo/function/provider.dart';
import 'package:note_app_vtwo/settings/style_and_colors_utils.dart';
import 'package:note_app_vtwo/widget/entity/entitasLaporanMobil.dart';
import 'package:note_app_vtwo/widget/header/userHeader_custom.dart';
import 'package:provider/provider.dart';

class LaporanPermobilMenuPage extends StatefulWidget {
  final Function(int) onItemTapped;
  final Function(int) showTruckDetails;

  const LaporanPermobilMenuPage(
      {super.key, required this.onItemTapped, required this.showTruckDetails});

  @override
  State<LaporanPermobilMenuPage> createState() =>
      _LaporanPermobilMenuPageState();
}

class _LaporanPermobilMenuPageState extends State<LaporanPermobilMenuPage> {
  final DatabaseHelper _databasehelper = DatabaseHelper();
  List<Truck> _filteredTrucks = [];
  String _searchQuery = '';
  late List<Expense> _expenseId;
  final List<Truck> trucks = [];

  @override
  void initState() {
    super.initState();
    _loadExpenses(10);
    Provider.of<TruckProvider>(context, listen: false).loadTrucks();
  }

  // Future<void> _loadTruckData(int id) async {
  //   print('Mencoba memuat data untuk ID: $id');
  //   try {
  //     _truckId = await _databasehelper.getTruckById(id);
  //     print('truk data berhasil di load : $_truckId');
  //   } catch (e) {
  //     print('gagal cuy');
  //   }

  //   setState(() {});
  // }

  Future<void> _loadExpenses(int truckId) async {
    try {
      print('dapet cuy : $_expenseId');
      _expenseId = await _databasehelper.getExpenses(truckId);
    } catch (e) {
      print('error kocak : $e');
    }
    setState(() {});
  }

  void _searchTrucks(String query) {
    final truckProvider = Provider.of<TruckProvider>(context, listen: false);
    setState(() {
      _searchQuery = query;
      if (_searchQuery.isEmpty) {
        _filteredTrucks = truckProvider.trucks;
      }
      _filteredTrucks = truckProvider.trucks
          .where((truck) =>
              truck.platNomor.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  String formatDate(DateTime date) {
    return DateFormat('dd / MM / yyyy').format(date);
  }

  @override
  Widget build(BuildContext context) {
    final truckProvider = Provider.of<TruckProvider>(context);
    setState(() {
      _filteredTrucks = truckProvider.trucks.where((truck) {
        return truck.platNomor
            .toLowerCase()
            .contains(_searchQuery.toLowerCase());
      }).toList();
    });

    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
    return Scaffold(
      backgroundColor: bgColor,
      body: Row(
        children: [
          Expanded(
              child: Column(
            children: [
              UserheaderCustom(
                onSearch: _searchTrucks,
                iconHeader: 'assets/report icon.svg',
                titleHeader: 'Laporan Mobil',
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      if (_filteredTrucks.isEmpty)
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal:
                                  MediaQuery.sizeOf(context).width * 0.05,
                              vertical:
                                  MediaQuery.sizeOf(context).height * 0.3),
                          child: Text(
                            'Tidak ada data yang ditemukan',
                            style: GoogleFonts.poppins(
                                color: mainColor,
                                fontSize:
                                    MediaQuery.sizeOf(context).width * 0.02,
                                fontWeight: FontWeight.bold),
                          ),
                        )
                      else
                        for (var truck in _filteredTrucks)
                          EntitasLaporanMobil(
                            sisaBudget: NumberFormat.currency(
                                    locale: 'id_ID', symbol: 'Rp. ')
                                .format(truck.remainingBudget),
                            tanggalInput: formatDate(DateTime.now()),
                            navigate: () {
                              //widget.onItemTapped(4);
                              widget.showTruckDetails(truck.id);
                            },
                            number: truck.number,
                            platnomor: truck.platNomor,
                          ),
                    ],
                  ),
                ),
              ),
            ],
          ))
        ],
      ),
    );
  }
}
