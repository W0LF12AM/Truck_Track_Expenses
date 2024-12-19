import 'package:flutter/foundation.dart';
import 'package:note_app_vtwo/data/databaseHelper.dart';
import 'package:note_app_vtwo/data/model.dart';

class TruckProvider with ChangeNotifier {
  final DatabaseHelper _databaseHelper = DatabaseHelper();
  List<Truck> _trucks = [];

  List<Truck> get trucks => _trucks;

  Future<void> loadTrucks() async {
    _trucks = await _databaseHelper.getTrucks();

    for (int i = 0; i < _trucks.length; i++) {
      _trucks[i].number = i + 1; 
    }
    notifyListeners(); 
  }

  Future<void> addTruck(Truck truck) async {
    await _databaseHelper.insertTruck(truck);
    await loadTrucks(); 
  }

  Future<void> deleteTruck(int id) async {
    await _databaseHelper.deleteTruck(id);
    await loadTrucks(); 
  }
}
