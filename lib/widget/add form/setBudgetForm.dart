import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:note_app_vtwo/data/databaseHelper.dart';
import 'package:note_app_vtwo/data/model.dart';
import 'package:note_app_vtwo/function/provider.dart';
import 'package:note_app_vtwo/settings/style_and_colors_utils.dart';
import 'package:note_app_vtwo/widget/dialog/dialogDataDisimpan.dart';
import 'package:provider/provider.dart';

class Setbudgetform extends StatefulWidget {
  const Setbudgetform({super.key});

  @override
  State<Setbudgetform> createState() => _SetbudgetformState();
}

class _SetbudgetformState extends State<Setbudgetform> {
  List<Truck> trucks = [];
  List<Truck> filteredTrucks = [];
  String? selectedPlatNomor;
  TextEditingController platNomorController = TextEditingController();
  TextEditingController budgetController = TextEditingController();
  OverlayEntry? overlayEntry;

  @override
  void initState() {
    super.initState();
    _loadTrucks();
  }

  Future<void> _loadTrucks() async {
    final trucks = Provider.of<TruckProvider>(context, listen: false).trucks;
    setState(() {
      filteredTrucks = trucks;
    });
  }

  void _filterPlatNomor(String query) {
    if (query.isEmpty) {
      setState(() {
        filteredTrucks =
            Provider.of<TruckProvider>(context, listen: false).trucks;
      });
      _removeOverlay();
    } else {
      setState(() {
        filteredTrucks = Provider.of<TruckProvider>(context, listen: false)
            .trucks
            .where((truck) =>
                truck.platNomor.toLowerCase().contains(query.toLowerCase()))
            .toList();
      });
      _showOverlay(context);
    }
  }

  void _showOverlay(BuildContext context) {
    if (overlayEntry != null) {
      overlayEntry!.remove();
    }

    overlayEntry = OverlayEntry(
        builder: (context) => Positioned(
            left: MediaQuery.sizeOf(context).width * 0.45,
            right: MediaQuery.sizeOf(context).width * 0.45,
            top: MediaQuery.sizeOf(context).height * 0.5,
            child: Material(
              elevation: 4.0,
              child: Container(
                  height: 150,
                  width: 100,
                  decoration: BoxDecoration(
                      color: secondaryColor,
                      borderRadius: BorderRadius.circular(5),
                      boxShadow: [
                        BoxShadow(color: Colors.black26, blurRadius: 4.0)
                      ]),
                  child: filteredTrucks.isNotEmpty
                      ? ListView.builder(
                          itemCount: filteredTrucks.length > 5
                              ? 5
                              : filteredTrucks.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              title: Text(
                                filteredTrucks[index].platNomor,
                                style: GoogleFonts.poppins(
                                    fontSize:
                                        MediaQuery.sizeOf(context).width * 0.01,
                                    fontWeight: FontWeight.bold),
                              ),
                              onTap: () {
                                setState(() {
                                  selectedPlatNomor =
                                      filteredTrucks[index].platNomor;
                                  platNomorController.text = selectedPlatNomor!;
                                  filteredTrucks = [];
                                });
                                _removeOverlay();
                              },
                            );
                          })
                      : Center(
                          child: Padding(
                            padding: EdgeInsets.all(8),
                            child: Text(
                              'Truk tidak terdaftar',
                              style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        )),
            )));
    Overlay.of(context)!.insert(overlayEntry!);
  }

  void _saveData() async {
    String budgetText = budgetController.text;
    String sanitizedBudget = budgetText.replaceAll(RegExp(r'[^0-9]'), '');
    int budgetValue = int.parse(sanitizedBudget);

    if (selectedPlatNomor != null) {
      List<Truck> trucks = await DatabaseHelper().getTrucks();
      Truck? truckToUpdate = trucks.firstWhere(
          (truck) => truck.platNomor == selectedPlatNomor,
          orElse: () =>
              Truck(id: -1, platNomor: '', number: 0, budgetTahunan: 0.0));
      if (truckToUpdate.id != -1) {
        await Provider.of<TruckProvider>(context, listen: false)
            .updateBudget(truckToUpdate.id, budgetValue);

        platNomorController.clear();
        budgetController.clear();
        selectedPlatNomor = null;

        showDialog(
            context: context,
            builder: (BuildContext context) {
              return Dialog(
                backgroundColor: Colors.transparent,
                child: Dialogdatadisimpan(
                    titleCard: 'Data Berhasil Disimpan',
                    pesan: 'Data yang sudah anda set \nberhasil dismpan'),
              );
            }).catchError((error) {
          print('error save budget : $error');
        });
      }
    }

    // DatabaseHelper databaseHelper = DatabaseHelper();
    // databaseHelper.saveBudget(selectedPlatNomor!, budgetValue);
  }

  void _onChanged(String value) {
    String sanitizedValue = value.replaceAll(RegExp(r'[^0-9]'), '');

    if (sanitizedValue.isNotEmpty) {
      String formattedHarga = NumberFormat.currency(
              locale: 'id_ID', symbol: 'Rp. ', decimalDigits: 0)
          .format(int.parse(sanitizedValue));

      budgetController.value = TextEditingValue(
          text: formattedHarga,
          selection: TextSelection.collapsed(offset: formattedHarga.length));
    } else {
      budgetController.clear();
    }
  }

  void _removeOverlay() {
    if (overlayEntry != null) {
      overlayEntry!.remove();
      overlayEntry = null;
    }
  }

  @override
  void dispose() {
    overlayEntry?.remove();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: MediaQuery.of(context).size.height * 0.17),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.4,
        height: MediaQuery.of(context).size.height * 0.5,
        decoration: BoxDecoration(
            color: secondaryColor, borderRadius: BorderRadius.circular(30)),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.045,
                    left: MediaQuery.sizeOf(context).width * 0.025,
                    bottom: MediaQuery.sizeOf(context).height * 0.04),
                child: Row(
                  children: [
                    Text(
                      'Set Budget',
                      style: GoogleFonts.poppins(
                          color: mainColor,
                          fontSize: MediaQuery.of(context).size.width * 0.02,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.sizeOf(context).width * 0.05),
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.06,
                  decoration: BoxDecoration(
                      color: formColor, borderRadius: BorderRadius.circular(5)),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: GestureDetector(
                      onTap: () {
                        _showOverlay(context);
                      },
                      child: TextField(
                        controller: platNomorController,
                        onChanged: _filterPlatNomor,
                        textAlign: TextAlign.start,
                        textAlignVertical: TextAlignVertical.center,
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.bold,
                            fontSize:
                                MediaQuery.of(context).size.width * 0.013),
                        decoration: InputDecoration(
                            hintText: 'Plat Nomor',
                            hintStyle: GoogleFonts.poppins(
                              fontWeight: FontWeight.bold,
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.013,
                            ),
                            border: InputBorder.none,
                            suffixIcon: Icon(
                              Icons.arrow_drop_down,
                              color: Colors.grey,
                              size: 50,
                            )),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.sizeOf(context).height * 0.02,
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.sizeOf(context).width * 0.05),
                child: Expanded(
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.06,
                    decoration: BoxDecoration(
                        color: formColor,
                        borderRadius: BorderRadius.circular(5)),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: TextField(
                        onChanged: _onChanged,
                        controller: budgetController,
                        textAlign: TextAlign.start,
                        textAlignVertical: TextAlignVertical.center,
                        style: GoogleFonts.poppins(
                            fontSize: MediaQuery.of(context).size.width * 0.013,
                            fontWeight: FontWeight.bold),
                        decoration: InputDecoration(
                          hintText: 'Budget',
                          hintStyle: GoogleFonts.poppins(
                            fontWeight: FontWeight.bold,
                            fontSize: MediaQuery.of(context).size.width * 0.013,
                          ),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.sizeOf(context).height * 0.04,
              ),
              GestureDetector(
                onTap: () {
                  _saveData();
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.sizeOf(context).width * 0.05),
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.06,
                    width: MediaQuery.of(context).size.width * 0.5,
                    decoration: BoxDecoration(
                        color: mainColor,
                        borderRadius: BorderRadius.circular(10)),
                    child: Center(
                      child: Text(
                        'Simpan',
                        style: GoogleFonts.poppins(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
