import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:note_app_vtwo/data/model.dart';
import 'package:note_app_vtwo/function/provider.dart';

import 'package:note_app_vtwo/settings/style_and_colors_utils.dart';
import 'package:note_app_vtwo/widget/dialog/dialogTruckSudahAda.dart';
import 'package:note_app_vtwo/widget/entity/entitasMobil.dart';
import 'package:note_app_vtwo/widget/add%20form/tambahMobilDialog.dart';
import 'package:note_app_vtwo/widget/header/userHeader_custom.dart';
import 'package:provider/provider.dart';

class KelolaMobilPage extends StatefulWidget {
  const KelolaMobilPage({super.key});

  @override
  State<KelolaMobilPage> createState() => _KelolaMobilPageState();
}

class _KelolaMobilPageState extends State<KelolaMobilPage> {
  List<Truck> _trucks = [];
  List<Truck> _filteredTrucks = [];
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    Provider.of<TruckProvider>(context, listen: false).loadTrucks();
  }

  // Future<void> _loadTrucks() async {
  //   try {
  //     List<Truck> trucks = await _databasehelper.getTrucks();
  //     setState(() {
  //       _trucks = trucks;
  //       _filteredTrucks = trucks;
  //     });
  //     print('Trucks loaded: $_trucks');
  //   } catch (e) {
  //     print('Error loading trucks: $e');
  //   }
  // }

  void _filterTrucks(String query) {
    final truckProvider = Provider.of<TruckProvider>(context, listen: false);
    setState(() {
      _searchQuery = query;
      if (query.isEmpty) {
        _filteredTrucks = truckProvider.trucks;
      }
      _filteredTrucks = truckProvider.trucks
          .where((truck) =>
              truck.platNomor.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  void _addTruck(String platNomor) async {
    final truckProvider = Provider.of<TruckProvider>(context, listen: false);

    bool exist = truckProvider.trucks.any((truck) =>
        truck.platNomor.toLowerCase().trim() == platNomor.toLowerCase().trim());

    if (exist) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return Dialog(
                backgroundColor: Colors.transparent,
                child: Dialogtrucksudahada(
                    titleCard: 'Truck Already Exist',
                    pesan: 'Truck dengan plat nomor tersebut sudah terdaftar.'),
              );
            });
      });

      return;
    }
    Truck newTruck = Truck(
        id: 0,
        platNomor: platNomor,
        number: _trucks.length + 1,
        budgetTahunan: 0);
    truckProvider.addTruck(newTruck);
  }

  void _deleteTruck(int id) async {
    final truckProvider = Provider.of<TruckProvider>(context, listen: false);
    print('truk dengan id : $id dihapus');
    truckProvider.deleteTruck(id);
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
