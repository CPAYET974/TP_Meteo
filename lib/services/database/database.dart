import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:tp_weather/models/location_model.dart';

class LocationsDatabase {
  static final LocationsDatabase instance = LocationsDatabase._init();

  static Database? _database;
  LocationsDatabase._init();

  Future<Database> get database async {
    if (_database == null) return _database!;
    _database = await _initDB(tableName);
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    await db.execute(
        'CREATE TABLE $tableName(id INTEGER PRIMARY KEY AUTOINCREMENT, cityName TEXT)');
  }

  Future<void> _insert(Location location) async {
    final db = await instance.database;

    final id = await db.insert(
      tableName,
      location.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Location>> _read() async {
    final db = await database;

    final List<Map<String, dynamic>> maps = await db.query(tableName);

    return List.generate(
      maps.length,
      (i) {
        return Location(
          id: maps[i]['id'],
          cityName: maps[i]['cityName'],
        );
      },
    );
  }

  Future<void> _deleteLocation(String cityName) async {
    final db = await database;

    await db.delete(
      tableName,
      where: 'cityName = ?',
      whereArgs: [cityName],
    );
  }

  Future _close() async {
    final db = await instance.database;

    db.close();
  }
}
