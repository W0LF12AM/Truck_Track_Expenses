class Truck {
  final int id;
  final String platNomor;
  int number;

  Truck({required this.id, required this.platNomor, required this.number});

  factory Truck.fromMap(Map<String, dynamic> map) {
    return Truck(
      id: map['id'],
      number: map['number'],
      platNomor: map['platNomor'],
    );
  }
}

class Budget {
  final int id;
  final int truckId;
  final double totalAnggaran;
  double sisaAnggaran;
  final DateTime year;
  final DateTime lastUpdate;

  Budget(
      {required this.id,
      required this.truckId,
      required this.totalAnggaran,
      required this.sisaAnggaran,
      required this.year,
      required this.lastUpdate});

  void updateSisaAnggaran(double harga) {
    sisaAnggaran -= harga;
  }

  factory Budget.fromMap(Map<String, dynamic> map) {
    return Budget(
        id: map['id'],
        truckId: map['truckId'],
        totalAnggaran: map['totalAnggaran'],
        sisaAnggaran: map['sisaAnggaran'],
        year: DateTime.parse(map['year']),
        lastUpdate: DateTime.parse(map['lastUpdate']));
  }
}

class Expense {
  final int id;
  final int truckId;
  final String onderdil;
  final double harga;
  final DateTime date;

  Expense({
    required this.id,
    required this.truckId,
    required this.onderdil,
    required this.harga,
    required this.date,
  });
}
