import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:note_app_vtwo/data/databaseHelper.dart';
import 'package:note_app_vtwo/data/model.dart';
import 'package:note_app_vtwo/settings/style_and_colors_utils.dart';

class Tambahlaporanpengeluaran extends StatefulWidget {
  final Truck truck;
  const Tambahlaporanpengeluaran({super.key, required this.truck});

  @override
  State<Tambahlaporanpengeluaran> createState() =>
      _TambahlaporanpengeluaranState();
}

class _TambahlaporanpengeluaranState extends State<Tambahlaporanpengeluaran> {
  final TextEditingController _onderdilController = TextEditingController();
  final TextEditingController _hagraController = TextEditingController();
  DateTime? _selectedDate;

  void _onChanged(String value) {
    String sanitizedValue = value.replaceAll(RegExp(r'[^0-9]'), '');

    if (sanitizedValue.isNotEmpty) {
      String formattedHarga = NumberFormat.currency(
              locale: 'id_ID', symbol: 'Rp. ', decimalDigits: 0)
          .format(int.parse(sanitizedValue));

      _hagraController.value = TextEditingValue(
          text: formattedHarga,
          selection: TextSelection.collapsed(offset: formattedHarga.length));
    } else {
      _hagraController.clear();
    }
  }

  void _submitExpense() {
    if (_onderdilController.text.isEmpty ||
        _hagraController.text.isEmpty ||
        _selectedDate == null) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: secondaryColor,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
            title: Text(
              'Peringatan',
              style: GoogleFonts.poppins(
                  fontSize: 25, fontWeight: FontWeight.bold),
            ),
            content: Text(
              'Semua field harus diisi!',
              style: GoogleFonts.poppins(
                  fontSize: 20, fontWeight: FontWeight.normal),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Tutup dialog
                },
                child: Text(
                  'OK',
                  style: GoogleFonts.poppins(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          );
        },
      );
      return;
    }

    String onderdil = _onderdilController.text;
    String sanitizedHarga =
        _hagraController.text.replaceAll(RegExp(r'[^0-9]'), '');
    double harga = double.tryParse(sanitizedHarga) ?? 0.0;

    // widget.truck.addExpense(onderdil, harga, _selectedDate!);

    Expense newExpense =
        Expense(onderdil: onderdil, harga: harga, date: _selectedDate!, id: 0);

    DatabaseHelper().insertExpense(newExpense, widget.truck.id).then((_) {
      print('Menambahkan pengeluaran: ${newExpense.toMap(widget.truck.id)}');
      Navigator.pop(context, newExpense);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      backgroundColor: secondaryColor,
      child: Container(
        width: MediaQuery.sizeOf(context).width * 0.45,
        height: MediaQuery.sizeOf(context).height * 0.47,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Tambah Data',
                style: GoogleFonts.poppins(
                    color: mainColor,
                    fontSize: MediaQuery.sizeOf(context).width * 0.017,
                    fontWeight: FontWeight.bold),
              ),
              Padding(
                padding: EdgeInsets.only(
                    right: MediaQuery.sizeOf(context).width * 0.35),
                child: Divider(
                  color: mainColor,
                  thickness: 3,
                ),
              ),
              SizedBox(
                height: MediaQuery.sizeOf(context).height * 0.03,
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: formColor,
                ),
                height: MediaQuery.sizeOf(context).height * 0.06,
                child: TextField(
                  controller: _onderdilController,
                  textAlign: TextAlign.start,
                  style: GoogleFonts.poppins(
                      fontWeight: FontWeight.bold, fontSize: 20),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Onderdil',
                    contentPadding: EdgeInsets.only(left: 10),
                  ),
                  keyboardType: TextInputType.number,
                ),
              ),
              SizedBox(
                height: MediaQuery.sizeOf(context).height * 0.02,
              ),

              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: formColor,
                ),
                height: MediaQuery.sizeOf(context).height * 0.06,
                child: TextField(
                  controller: _hagraController,
                  textAlign: TextAlign.start,
                  style: GoogleFonts.poppins(
                      fontWeight: FontWeight.bold, fontSize: 20),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Harga',
                    contentPadding: EdgeInsets.only(left: 10),
                  ),
                  onChanged: _onChanged,
                ),
              ),
              SizedBox(
                height: MediaQuery.sizeOf(context).height * 0.02,
              ),
              GestureDetector(
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                    helpText: 'Tanggal',
                    context: context,
                    firstDate: DateTime(2024),
                    lastDate: DateTime(2100),
                    builder: (context, child) {
                      return Theme(
                          data: ThemeData.light().copyWith(
                            primaryColor: mainColor,
                            colorScheme: ColorScheme.light(),
                          ),
                          child: child ?? Container());
                    },
                  );
                  if (pickedDate != null) {
                    setState(() {
                      _selectedDate = pickedDate;
                    });
                  }
                },
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5), color: formColor),
                  child: Padding(
                    padding: EdgeInsets.all(
                        MediaQuery.sizeOf(context).width * 0.006),
                    child: Text(
                      textAlign: TextAlign.start,
                      _selectedDate == null
                          ? 'Pilih Tanggal'
                          : '${DateFormat('dd / MM / yyyy').format(_selectedDate!)}',
                      style: GoogleFonts.poppins(
                          fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                  ),
                ),
              ),
              // Container(
              //   decoration: BoxDecoration(
              //     borderRadius: BorderRadius.circular(5),
              //     color: formColor,
              //   ),
              //   height: MediaQuery.sizeOf(context).height * 0.06,
              //   child: TextField(
              //     controller: _hagraController,
              //     textAlign: TextAlign.start,
              //     style: GoogleFonts.poppins(
              //         fontWeight: FontWeight.bold, fontSize: 20),
              //     decoration: InputDecoration(
              //       border: InputBorder.none,
              //       hintText: 'Harga',
              //       contentPadding: EdgeInsets.only(left: 10),
              //     ),
              //   ),
              // ),

              SizedBox(
                height: MediaQuery.sizeOf(context).height * 0.03,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      width: MediaQuery.sizeOf(context).width * 0.048,
                      height: MediaQuery.sizeOf(context).height * 0.048,
                      decoration: BoxDecoration(
                          color: mainColor,
                          borderRadius: BorderRadius.circular(5)),
                      child: Padding(
                        padding: EdgeInsets.all(
                            MediaQuery.sizeOf(context).width * 0.006),
                        child: SvgPicture.asset(
                          'assets/cancel icon.svg',
                          color: secondaryColor,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.sizeOf(context).width * 0.005,
                  ),
                  GestureDetector(
                    onTap: () {
                      _submitExpense();
                    },
                    child: Container(
                      width: MediaQuery.sizeOf(context).width * 0.048,
                      height: MediaQuery.sizeOf(context).height * 0.048,
                      decoration: BoxDecoration(
                          color: mainColor,
                          borderRadius: BorderRadius.circular(5)),
                      child: Icon(
                        Icons.check,
                        color: secondaryColor,
                        size: MediaQuery.sizeOf(context).width * 0.02,
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
