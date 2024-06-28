import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static Database? _database;
  static const String dbName = 'liked_images.db';
  static const String tableName = 'likes';
  static const String colId = 'id';
  static const String colImageUrl = 'imageUrl';

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await initDatabase();
    return _database!;
  }

  Future<Database> initDatabase() async {
    String path = join(await getDatabasesPath(), dbName);
    return await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
          await db.execute('''
        CREATE TABLE $tableName (
          $colId INTEGER PRIMARY KEY AUTOINCREMENT,
          $colImageUrl TEXT
        )
        ''');
        });
  }

  Future<int> insert(String imageUrl) async {
    final db = await database;
    return await db.insert(tableName, {colImageUrl: imageUrl});
  }

  Future<int> delete(String imageUrl) async {
    final db = await database;
    return await db.delete(tableName, where: '$colImageUrl = ?', whereArgs: [imageUrl]);
  }

  Future<bool> isLiked(String imageUrl) async {
    final db = await database;
    var result = await db.query(tableName, where: '$colImageUrl = ?', whereArgs: [imageUrl]);
    return result.isNotEmpty;
  }

  Future<List<String>> getLikedImages() async {
    final db = await database;
    var result = await db.query(tableName);
    return List.generate(result.length, (index) => result[index][colImageUrl] as String);
  }
}
