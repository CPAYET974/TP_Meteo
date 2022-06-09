import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:tp_weather/models/location_model.dart';

class LocationsDatabase {
  static final LocationsDatabase instance = LocationsDatabase._init();
  static Database? _database;

  LocationsDatabase._init();

  Future<Database?> get database async {
    _database ??= await _initDB(tableName);
    return _database;
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

  Future<Location> create(tableName, location) async {
    final db = await instance.database;

    final id = await db!.insert(tableName, location.toJson());
    return location.copy(id: id);
  }

  Future<List<Location>> read() async {
    final db = await instance.database;

    // final orderBy = '${LocationFields.cityName} ASC';

    final result = await db!.query(tableName);

    return result.map((json) => Location.fromJson(json)).toList();
  }

  Future<void> deleteLocation(String cityName) async {
    final db = await database;

    await db?.delete(
      tableName,
      where: 'cityName = ?',
      whereArgs: [cityName],
    );
  }

  Future close() async {
    final db = await instance.database;

    db?.close();
  }
}
