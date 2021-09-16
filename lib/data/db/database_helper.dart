import 'package:restaurant_app/data/model/restaurant.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static DatabaseHelper? _instance;
  static Database? _database;

  DatabaseHelper._internal() {
    _instance = this;
  }

  factory DatabaseHelper() => _instance ?? DatabaseHelper._internal();

  static const String _tblFavorite = 'favorite';

  Future<Database> _initializeDb() async {
    var path = await getDatabasesPath();
    var db = openDatabase(
      '$path/favorite.db',
      onCreate: (db, version) async {
        await db.execute('''CREATE TABLE $_tblFavorite (
              id TEXT PRIMARY KEY,
              pictureId TEXT,
              name TEXT,
              city TEXT,
              rating REAL
           )
        ''');
      },
      version: 1,
    );

    return db;
  }

  Future<Database?> get database async {
    if (_database == null) {
      _database = await _initializeDb();
    }

    return _database;
  }

  Future<void> insertFavorite(Restaurant restaurant) async {
    final db = await database;
    var _json = restaurant.toJson();
    var result = {
      'id': _json['id'],
      'pictureId': _json['pictureId'],
      'name': _json['name'],
      'city': _json['city'],
      'rating': _json['rating']
    };
    await db!.insert(_tblFavorite, result);
  }

  Future<List<Restaurant>> getFavorites() async {
    final db = await database;
    List<Map<String, dynamic>> results = await db!.query(_tblFavorite);

    return results.map((res) => Restaurant.fromJson(res)).toList();
  }

  Future<bool> isFavorite(String pictureId) async {
    final db = await database;

    List<Map<String, dynamic>> results = await db!.query(
      _tblFavorite,
      where: 'pictureId = ?',
      whereArgs: [pictureId],
    );

    if (results.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

  Future<void> removeFavorite(String pictureId) async {
    final db = await database;

    await db!.delete(
      _tblFavorite,
      where: 'pictureId = ?',
      whereArgs: [pictureId],
    );
  }
}
