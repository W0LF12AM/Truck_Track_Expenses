import 'package:note_app_vtwo/data/model.dart';
import 'package:note_app_vtwo/main.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;

  static Database? _database;

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'truck_maintenance.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        return db.execute('''CREATE TABLE trucks(
            id INTEGER PRIMARY KEY AUTOINCREMENT, 
            platNomor TEXT, 
            budgetTahunan REAL, 
            number INTEGER
            );
            CREATE TABLE expenses(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            truckId INTEGER,
            onderdil TEXT,
            harga REAL,
            date TEXT,
            FOREIGN KEY (truckId) REFERENCES trucks(id) ON DELETE CASCADE
            );
            ''');
      },
    );
  }

  //-----------------------------------------------------------------------------//

  Future<void> insertTruck(Truck truck) async {
    final db = await database;
    await db.insert('trucks', truck.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<Map<String, dynamic>>> getAllTrucks() async {
    final db = await database;
    // final List<Map<String, dynamic>> maps = await db.query('trucks');
    return await db.query('trucks');
    // return List.generate(maps.length, (i) {
    //   return Truck.fromMap(maps[i]);
    // });
  }

  Future<List<Truck>> getTrucks() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('trucks');

    return List.generate(maps.length, (i) {
      return Truck.fromMap(maps[i]);
    });
  }

  Future<Truck?> getTruckById(int id) async {
    final db = await database;
    final List<Map<String, dynamic>> maps =
        await db.query('trucks', where: 'id = ?', whereArgs: [id]);

    if (maps.isNotEmpty) {
      return Truck.fromMap(maps.first);
    }
    return null;
  }

  Future<void> deleteTruck(int id) async {
    final db = await database;
    await db.delete('trucks', where: 'id = ?', whereArgs: [id]);

    final List<Map<String, dynamic>> maps = await db.query('trucks');
    for (int i = 0; i < maps.length; i++) {
      await db.update('trucks', {'number': i + 1},
          where: 'id = ?', whereArgs: [maps[i]['id']]);
    }
  }

  Future<void> saveBudget(int id, int budgetTahunan) async {
    final db = await database;
    await db.update('trucks', {'budgetTahunan': budgetTahunan},
        where: 'id = ?', whereArgs: [id]);
  }

  //-----------------------------------------------------------------------------//

  Future<void> insertExpense(Expense expense, int truckId) async {
    final db = await database;
    await db.insert('expenses', expense.toMap(truckId),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> addExpense(Expense expense) async {
    final db = await database;
    await db.insert(
      'expenses',
      expense.toMap(expense.id),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Expense>> getExpenses(int truckId) async {
    final db = await database;
    final List<Map<String, dynamic>> maps =
        await db.query('expenses', where: 'truckId = ?', whereArgs: [truckId]);

    return List.generate(maps.length, (i) {
      return Expense.fromMap(maps[i]);
    });
  }

  Future<void> updateExpense(Expense expense) async {
    final db = await database;
    await db.update('expenses', expense.toMap(expense.id),
        where: 'id = ?', whereArgs: [expense.id]);
  }

  Future<void> deleteExpense(int id) async {
    final db = await database;
    await db.delete('expenses', where: 'id = ?', whereArgs: [id]);
  }

  Future<List<Expense>> getExpensesByTruckId(int truckId) async {
    final db = await database;
    final List<Map<String, dynamic>> maps =
        await db.query('expenses', where: 'truckId = ?', whereArgs: [truckId]);

    return List.generate(maps.length, (i) {
      return Expense.fromMap(maps[i]);
    });
  }

  Future<void> deleteExpensesByTruckId(int truckId) async {
    final db = await database;
    await db.delete(
      'expenses',
      where: 'truckId = ?',
      whereArgs: [truckId],
    );
  }

  //-----------------------------------------------------------------------------//

  Future<List<double>> getMonthlyMaintenanceData(int truckId) async {
    final db = await database;
    List<double> maintenanceData = List.filled(12, 0);

    final List<Map<String, dynamic>> maps = await db.rawQuery(
        '''SELECT strftime('%m', date) as month, SUM(harga) as total FROM expenses WHERE truckId = ? GROUP BY month''', [truckId]);

    for (var map in maps) {
      int month = int.parse(map['month']);
      maintenanceData[month - 1] = map['total']?.toDouble() ?? 0;
    }
    return maintenanceData;
  }
}
















































// import 'package:note_app_vtwo/data/model.dart';
// import 'package:path/path.dart';
// import 'package:sqflite/sqflite.dart';

// class Databasehelper {
//   static final Databasehelper _instance = Databasehelper._internal();
//   factory Databasehelper() => _instance;

//   static Database? _database;

//   Databasehelper._internal();

//   Future<Database> get database async {
//     if (_database != null) return _database!;
//     _database = await _initDatabase();
//     return _database!;
//   }

//   Future<Database> _initDatabase() async {
//     String path = join(await getDatabasesPath(), 'note_app.db');
//     return await openDatabase(path, version: 1, onCreate: (db, version) {
//       return db.execute('''
//             CREATE TABLE trucks(id INTEGER PRIMARY KEY, platNomor TEXT, number INTEGER);
//             CREATE TABLE expenses(id INTEGER PRIMARY KEY, truckId INTEGER, onderdil TEXT, harga REAL, date TEXT);
//             ''');
//     }, onUpgrade: (db, oldVersion, newVersion) async {
//       if (oldVersion < 2) {
//         await db.execute('DROP TABLE IF EXISTS budgtes');
//         await db.execute('''
//           CREATE TABLE budgets(
//             id INTEGER PRIMARY KEY,
//             truckId INTEGER,
//             totalAnggaran REAL,
//             sisaAnggaran REAL,
//             year INTEGER,
//             FOREIGN KEY (truckId) REFERENCES trucks(id) ON DELETE CASCADE
//           );
//         ''');
//       }
//     });
//   }

//   //----------------------------------------------------------------------------------------------//

//   Future<void> tambahTruck(Truck truk) async {
//     final db = await database;
//     await db.insert(
//         'trucks', {'platNomor': truk.platNomor, 'number': truk.number},
//         conflictAlgorithm: ConflictAlgorithm.replace);
//   }

//   Future<List<Truck>> getTrucks() async {
//     final db = await database;
//     final List<Map<String, dynamic>> maps = await db.query(
//       'trucks',
//     );

//     return List.generate(maps.length, (i) {
//       return Truck.fromMap(maps[i]
//           // id: maps[i]['id'],
//           // platNomor: maps[i]['platNomor'],
//           // number: maps[i]['number'] ?? 0
//           );
//     });
//   }

//   Future<Truck?> getTruckById(int id) async {
//     final db = await database;
//     final List<Map<String, dynamic>> maps = await db.query(
//       'trucks',
//       where: 'id = ?',
//       whereArgs: [id],
//     );

//     if (maps.isNotEmpty) {
//       return Truck.fromMap(maps.first); // Mengembalikan objek Truck
//     } else {
//       return null; // Jika tidak ditemukan
//     }
//   }

//   Future<void> updateTruck(Truck truck) async {
//     final db = await database;
//     await db.update(
//         'trucks', {'platNomor': truck.platNomor, 'number': truck.number},
//         where: 'id = ?', whereArgs: [truck.id]);
//   }

//   Future<void> deleteTruck(int id) async {
//     final db = await database;
//     await db.delete('trucks', where: 'id = ?', whereArgs: [id]);
//   }

//   //----------------------------------------------------------------------------------------------//

//   Future<void> tambahBudget(Budget budget) async {
//     final db = await database;
//     await db.insert(
//         'budgets',
//         {
//           'truckId': budget.truckId,
//           'totalAnggaran': budget.totalAnggaran,
//           'sisaAnggaran': budget.sisaAnggaran,
//           'year': budget.year,
//         },
//         conflictAlgorithm: ConflictAlgorithm.replace);
//   }

//   Future<List<Budget>> getBudgets() async {
//     final db = await database;
//     final List<Map<String, dynamic>> maps = await db.query('budgets');

//     return List.generate(maps.length, (i) {
//       return Budget.fromMap(maps[i]
//           // id: maps[i]['id'],
//           // truckId: maps[i]['truckId'],
//           // totalAnggaran: maps[i]['totalAnggaran'],
//           // sisaAnggaran: maps[i]['sisaAnggaran'],
//           // year: DateTime(
//           //   maps[i]['year'],
//           // ),
//           // lastUpdate: DateTime.parse(maps[i]['lastUpdate'])
//           );
//     });
//   }

//   Future<void> updateBudget(Budget budget) async {
//     final db = await database;
//     await db.update(
//         'budget',
//         {
//           'totalAnggaran': budget.totalAnggaran,
//           'sisaAnggaran': budget.sisaAnggaran,
//           'year': budget.year
//         },
//         where: 'id = ?',
//         whereArgs: [budget.id]);
//   }

//   Future<void> deleteBudget(int id) async {
//     final db = await database;
//     await db.delete('budgets', where: 'id = ?', whereArgs: [id]);
//   }

//   //----------------------------------------------------------------------------------------------//

//   Future<void> tambahExpense(Expense expense) async {
//     final db = await database;
//     await db.insert(
//         'expenses',
//         {
//           'truckId': expense.truckId,
//           'onderdil': expense.onderdil,
//           'harga': expense.harga,
//           'date': expense.date.toIso8601String(),
//         },
//         conflictAlgorithm: ConflictAlgorithm.replace);
//   }

//   Future<List<Expense>> getExpenses(int truckId) async {
//     final db = await database;
//     final List<Map<String, dynamic>> maps =
//         await db.query('expenses', where: 'truckId = ?', whereArgs: [truckId]);
//     return List.generate(maps.length, (i) {
//       return Expense(
//           id: maps[i]['id'],
//           truckId: maps[i]['truckId'],
//           onderdil: maps[i]['onderdil'],
//           harga: maps[i]['harga'],
//           date: DateTime.parse(maps[i]['date']));
//     });
//   }

//   Future<void> updateExpense(Expense expense) async {
//     final db = await database;
//     await db.update(
//         'expenses',
//         {
//           'onderdil': expense.onderdil,
//           'harga': expense.harga,
//           'date': expense.date.toIso8601String(),
//         },
//         where: 'id = ?',
//         whereArgs: [expense.id]);
//   }

//   Future<void> deleteExpense(int id) async {
//     final db = await database;
//     await db.delete('expenses', where: 'id = ?', whereArgs: [id]);
//   }
// }

