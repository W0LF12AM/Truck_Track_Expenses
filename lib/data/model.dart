import 'package:flutter/material.dart';

class Truck {
  final int id;
  final String platNomor;
  int number;
  final double budgetTahunan;
  List<Expense> expenses;

  Truck({
    required this.id,
    required this.platNomor,
    required this.number,
    required this.budgetTahunan,
    List<Expense>? expenses,
  }) : expenses = expenses ?? [];

  void addExpense(String onderdil, double harga, DateTime date, TimeOfDay time) {
    expenses.add(Expense(
      onderdil: onderdil,
      harga: harga,
      date: date,
      id: id,
      time: time, // Simpan waktu
    ));
  }

  double get totalExpense {
    double total = expenses.fold(0.0, (sum, expense) => sum + expense.harga);
    print("Total Expense calculated: $total");
    return total;
  }

  double get remainingBudget {
    double remaining = budgetTahunan - totalExpense;
    print("Remaining Budget calculated: $remaining");
    return remaining;
  }

  Map<String, dynamic> toMap() {
    return {
      'platNomor': platNomor,
      'budgetTahunan': budgetTahunan,
      'number': number,
    };
  }

  factory Truck.fromMap(Map<String, dynamic> map) {
    return Truck(
      id: map['id'],
      number: map['number'] ?? 0,
      platNomor: map['platNomor'],
      budgetTahunan: map['budgetTahunan'] ?? 0.0,
    );
  }
}

class Expense {
  final int id;
  final String onderdil;
  final double harga;
  final DateTime date;
  final TimeOfDay time; // Tambahkan properti untuk waktu

  Expense({
    required this.id,
    required this.onderdil,
    required this.harga,
    required this.date,
    required this.time, // Tambahkan parameter ini
  });

  Map<String, dynamic> toMap(int truckId) {
    return {
      'truckId': truckId,
      'onderdil': onderdil,
      'harga': harga,
      'date': date.toIso8601String(),
      'time': '${time.hour}:${time.minute}', // Tambahkan waktu ke map
    };
  }

  factory Expense.fromMap(Map<String, dynamic> map) {
    double harga = map['harga']?.toDouble() ?? 0.0;
    print("Loaded Expense: ${map['onderdil']}, Harga: $harga");
    
    // Ambil waktu dari map dan konversi ke TimeOfDay
    List<String> timeParts = map['time']?.split(':') ?? ['0', '0'];
    TimeOfDay time = TimeOfDay(hour: int.parse(timeParts[0]), minute: int.parse(timeParts[1]));

    return Expense(
      id: map['id'],
      onderdil: map['onderdil'],
      harga: harga,
      date: DateTime.parse(map['date']),
      time: time, // Tambahkan waktu ke Expense
    );
  }
}