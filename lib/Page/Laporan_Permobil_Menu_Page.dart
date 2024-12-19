import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:note_app_vtwo/data/model.dart';
import 'package:note_app_vtwo/function/provider.dart';
import 'package:note_app_vtwo/settings/style_and_colors_utils.dart';
import 'package:note_app_vtwo/widget/entity/entitasLaporanMobil.dart';
import 'package:note_app_vtwo/widget/header/userHeader_custom.dart';
import 'package:provider/provider.dart';

class LaporanPermobilMenuPage extends StatefulWidget {
  final Function(int) onItemTapped;

  const LaporanPermobilMenuPage({super.key, required this.onItemTapped});

  @override
  State<LaporanPermobilMenuPage> createState() =>
      _LaporanPermobilMenuPageState();
}

class _LaporanPermobilMenuPageState extends State<LaporanPermobilMenuPage> {
  List<Truck> _filteredTrucks = [];
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    Provider.of<TruckProvider>(context, listen: false).loadTrucks();
  }

  // Future<void> _loadTrucks() async {
  //   List<Truck> trucks = await _databasehelper.getTrucks();

  //   print('truk loaded bwang : $trucks');

  //   setState(() {
  //     _trucks = trucks;
  //     _filteredTrucks = trucks;
  //   });
  // }

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
    _filteredTrucks = truckProvider.trucks.where((truck) {
      return truck.platNomor.toLowerCase().contains(_searchQuery.toLowerCase());
    }).toList();
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
                            sisaBudget: truck.platNomor,
                            tanggalInput: formatDate(DateTime.now()),
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
