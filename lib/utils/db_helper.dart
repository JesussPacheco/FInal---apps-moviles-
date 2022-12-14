import 'package:app_mycinees/models/restaurant.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DbHelper {
  final int version = 1;
  Database? db;

  static final DbHelper _dbHelper = DbHelper._internal();

  DbHelper._internal();

  factory DbHelper() {
    return _dbHelper;
  }

  Future<Database> openDb() async {
    if (db == null) {
      db = await openDatabase(join(await getDatabasesPath(), 'restaurants.db'),
          onCreate: (db, version) {
            db.execute(
                'CREATE TABLE restaurants(id INTEGER PRIMARY KEY, title TEXT)');
          }, version: version);
    }
    return db!;
  }

  Future<int> insertRestaurant(Restaurant restaurant) async {
    int id = await db!.insert('restaurants', restaurant.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);//opcional
    return id;
  }

  Future<bool> isFavorite(Restaurant restaurant) async {
    final List<Map<String, dynamic>> maps =
    await db!.query('restaurants', where: 'id = ?', whereArgs: [restaurant.id]);
    print("maps --> ");
    print(maps.length);
    return maps.length > 0;
  }

  Future<int> deleteRestaurant(Restaurant restaurant) async {
    int result =
    await db!.delete('restaurants', where: 'id = ?', whereArgs: [restaurant.id]);
    return result;
  }
}