import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'user_model.dart';

class DatabaseHelper {
  static Database? _myDatabase;

  Future<Database> getDatabaseConnection() async {
    if (_myDatabase != null) {
      return _myDatabase!;
    }

    String databaseFolderPath = await getDatabasesPath();
    String databaseFilePath = join(databaseFolderPath, 'user_database.db');

    _myDatabase = await openDatabase(
      databaseFilePath,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE users (
            id TEXT PRIMARY KEY,
            name TEXT,
            email TEXT,
            password TEXT
          )
        ''');
      },
    );
    return _myDatabase!;
  }

  // CREATE (Insert)
  Future<void> insertUser(UserModel user) async {
    Database db = await getDatabaseConnection();
    await db.insert(
      'users',
      user.convertToMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // READ ALL (Fetch)
  Future<List<UserModel>> getAllUsers() async {
    Database db = await getDatabaseConnection();
    List<Map<String, dynamic>> rawDataList = await db.query('users');

    List<UserModel> userObjectsList = [];
    for (var mapItem in rawDataList) {
      userObjectsList.add(UserModel.convertFromMap(mapItem));
    }
    return userObjectsList;
  }

  // READ SINGLE (Login Authentication)
  Future<UserModel?> checkLoginCredentials(String email, String password) async {
    Database db = await getDatabaseConnection();
    List<Map<String, dynamic>> matchingRows = await db.query(
      'users',
      where: 'email = ? AND password = ?',
      whereArgs: [email, password],
    );

    if (matchingRows.isNotEmpty) {
      return UserModel.convertFromMap(matchingRows.first);
    }
    return null;
  }

  // UPDATE
  Future<void> updateUserRecord(UserModel user) async {
    Database db = await getDatabaseConnection();
    await db.update(
      'users',
      user.convertToMap(),
      where: 'id = ?',
      whereArgs: [user.id],
    );
  }

  // DELETE
  Future<void> deleteUserRecord(String id) async {
    Database db = await getDatabaseConnection();
    await db.delete(
      'users',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
