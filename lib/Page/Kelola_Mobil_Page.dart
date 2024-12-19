import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:note_app_vtwo/data/databaseHelper.dart';
import 'package:note_app_vtwo/data/model.dart';

import 'package:note_app_vtwo/settings/style_and_colors_utils.dart';
import 'package:note_app_vtwo/widget/entity/entitasMobil.dart';
import 'package:note_app_vtwo/widget/add%20form/tambahMobilDialog.dart';
import 'package:note_app_vtwo/widget/header/userHeader_custom.dart';

class KelolaMobilPage extends StatefulWidget {
  const KelolaMobilPage({super.key});

  @override
  State<KelolaMobilPage> createState() => _KelolaMobilPageState();
}

class _KelolaMobilPageState extends State<KelolaMobilPage> {
  List<Truck> _trucks = [];
  List<Truck> _filteredTrucks = [];
  String _searchQuery = '';

  final Databasehelper _databasehelper = Databasehelper();

  @override
  void initState() {
    super.initState();
    _loadTrucks();
  }

  Future<void> _loadTrucks() async {
    List<Truck> trucks = await _databasehelper.getTrucks();
    setState(() {
      _trucks = trucks;
      _filteredTrucks = trucks;
    });
  }

  void _filterTrucks(String query) {
    setState(() {
      _searchQuery = query;
      if (query.isEmpty) {
        _filteredTrucks = _trucks;
      }
      _filteredTrucks = _trucks
          .where((truck) =>
              truck.platNomor.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  void _addTruck(String platNomor) async {
    Truck newTruck =
        Truck(id: 0, platNomor: platNomor, number: _trucks.length + 1);
    await _databasehelper.tambahTruck(newTruck);
    _loadTrucks();
  }

  void _deleteTruck(int id) async {
    print('truk dengan id : $id dihapus');
    await _databasehelper.deleteTruck(id);
    List<Truck> sisaEntitas = await _databasehelper.getTrucks();

    for (int i = 0; i < sisaEntitas.length; i++) {
      Truck truck = sisaEntitas[i];
      truck.number = i + 1;
      await _databasehelper.updateTruck(truck);
    }

    _loadTrucks();
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
                  onSearch: _filterTrucks,
                  iconHeader: 'assets/car icon.svg',
                  titleHeader: 'Kelola Mobil',
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
                            Entitasmobil(
                                id: truck.id,
                                number: truck.number,
                                platnomor: truck.platNomor,
                                deleteEntity: () {
                                  _deleteTruck(truck.id);
                                }),
                        SizedBox(
                          height: 300,
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
      floatingActionButton: GestureDetector(
        onTap: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return Tambahmobildialog(
                  onAddTruck: _addTruck,
                );
              });
        },
        child: Container(
          decoration: BoxDecoration(
              border: Border.all(width: 2),
              borderRadius: BorderRadius.circular(15),
              color: secondaryColor),
          width: 70,
          height: 70,
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
