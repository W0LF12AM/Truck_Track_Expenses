import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:note_app_vtwo/data/databaseHelper.dart';
import 'package:note_app_vtwo/data/model.dart';
import 'package:note_app_vtwo/settings/style_and_colors_utils.dart';
import 'package:note_app_vtwo/widget/entity/entitasLaporanMobil.dart';
import 'package:note_app_vtwo/widget/header/userHeader_custom.dart';

class LaporanPermobilMenuPage extends StatefulWidget {
  final Function(int) onItemTapped;

  const LaporanPermobilMenuPage({super.key, required this.onItemTapped});

  @override
  State<LaporanPermobilMenuPage> createState() =>
      _LaporanPermobilMenuPageState();
}

class _LaporanPermobilMenuPageState extends State<LaporanPermobilMenuPage> {
  final Databasehelper _databasehelper = Databasehelper();
  List<Truck> _trucks = [];
  List<Budget> _budgets = [];
  List<Truck> _filteredTrucks = [];
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    List<Truck> trucks = await _databasehelper.getTrucks();
    List<Budget> budgets = await _databasehelper.getBudgets();

    print('truk loaded bwang : $trucks');
    print('budget loaded bwang : $budgets');

    setState(() {
      _trucks = trucks;
      _budgets = budgets;
      _filteredTrucks = trucks;
    });
  }

  void _searchTrucks(String query) {
    setState(() {
      _searchQuery = query;
      if (_searchQuery.isEmpty) {
        _filteredTrucks = _trucks;
      }
      _filteredTrucks = _trucks
          .where((truck) =>
              truck.platNomor.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  Budget getBudgetForTruck(int truckId) {
    return _budgets.firstWhere(
      (b) => b.truckId == truckId,
      orElse: () => Budget(
          id: 0,
          truckId: truckId,
          totalAnggaran: 0,
          sisaAnggaran: 0,
          year: DateTime.now(),
          lastUpdate: DateTime.now()),
    );
  }

  String formatDate(DateTime date) {
    return DateFormat('dd / MM / yyyy').format(date);
  }

  @override
  Widget build(BuildContext context) {
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
                            sisaBudget: getBudgetForTruck(truck.id)
                                .sisaAnggaran
                                .toString(),
                            tanggalInput: formatDate(
                                getBudgetForTruck(truck.id).lastUpdate),
                            navigate: () {
                              widget.onItemTapped(4);
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
