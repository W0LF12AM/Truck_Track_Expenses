import 'package:note_app_vtwo/data/model.dart';
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
            time TEXT, 
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
    return await db.query('trucks');
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
      expense.toMap(expense.id), // Pastikan toMap() mencakup waktu
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

  Future<List<double>> getMonthlyMaintenanceData() async {
    final db = await database;
    List<double> monthlyExpense = List.filled(12, 0);

    final List<Map<String, dynamic>> maps = await db.rawQuery(
        '''SELECT strftime('%m', date) as month, SUM(harga) as total FROM expenses GROUP BY month''');

    for (var map in maps) {
      int month = int.parse(map['month']);
      monthlyExpense[month - 1] = map['total']?.toDouble() ?? 0;
    }
    return monthlyExpense;
  }

  Future<void> clearAllTrucksData() async {
    final db = await database;
    await db.delete('trucks');
  }

  Future<void> clearAllExpenses() async {
    final db = await database;
    await db.delete('expenses');
  }
}
