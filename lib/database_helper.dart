import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'user_model.dart';

class DatabaseHelper {
  static Database? database;

  Future<Database> getDatabaseConnection() async {

    if (database != null) {
      return database!;
    }

    final databasePath = await getDatabasesPath();

    final databaseFile = join(databasePath, 'user_database.db');

    database = await openDatabase(
      databaseFile,
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

    return database!;
  }

  Future<void> insertUser(UserModel user) async {
    final db = await getDatabaseConnection();

    await db.insert(
      'users',
      user.convertToMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<UserModel>> getAllUsers() async {
    final db = await getDatabaseConnection();
    final usersData = await db.query('users');

    return usersData.map((user) {
      return UserModel.convertFromMap(user);
    }).toList();
  }

  Future<UserModel?> checkLoginCredentials(
      String email,
      String password,
      ) async {
    final db = await getDatabaseConnection();

    final userData = await db.query(
      'users',
      where: 'email = ? AND password = ?',
      whereArgs: [email, password],
    );

    if (userData.isNotEmpty) {
      return UserModel.convertFromMap(userData.first);
    }

    return null;
  }


  Future<void> updateUserRecord(UserModel user) async {
    final db = await getDatabaseConnection();

    await db.update(
      'users',
      user.convertToMap(),
      where: 'id = ?',
      whereArgs: [user.id],
    );
  }

  Future<void> deleteUserRecord(String id) async {
    final db = await getDatabaseConnection();

    await db.delete(
      'users',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
