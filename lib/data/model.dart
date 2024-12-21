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

  void addExpense(String onderdil, double harga, DateTime date) {
    expenses.add(Expense(onderdil: onderdil, harga: harga, date: date, id: id));
  }

  double get totalExpense {
    return expenses.fold(0, (sum, expense) => sum + expense.harga);
  }

  double get remainingBudget {
    return budgetTahunan - totalExpense;
  }

  Map<String, dynamic> toMap() {
    return {
      'platNomor': platNomor,
      'budgetTahunan': budgetTahunan,
      'number': number
    };
  }

  factory Truck.fromMap(Map<String, dynamic> map) {
    return Truck(
        id: map['id'],
        number: map['number'],
        platNomor: map['platNomor'],
        budgetTahunan: map['budgetTahunan']);
  }
}

class Expense {
  final int id;
  final String onderdil;
  final double harga;
  final DateTime date;

  Expense(
      {required this.onderdil,
      required this.harga,
      required this.date,
      required this.id});

  Map<String, dynamic> toMap(int truckId) {
    return {
      'truckId': truckId,
      'onderdil': onderdil,
      'harga': harga,
      'date': date.toIso8601String()
    };
  }

  factory Expense.fromMap(Map<String, dynamic> map) {
    return Expense(
        id: map['id'],
        onderdil: map['onderdil'],
        harga: map['harga'],
        date: DateTime.parse(map['date']));
  }
}
