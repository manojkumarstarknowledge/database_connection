import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'user_model.dart';

class DatabaseHelper {
  static Database? database;

  Future<Database> getDatabaseConnection() async {
<<<<<<< HEAD:lib/database_helper.dart

    if (database != null) {
      return database!;
    }

    final databasePath = await getDatabasesPath();

    final databaseFile = join(databasePath, 'user_database.db');

=======
    if (database != null) return database!;

    final databasePath = await getDatabasesPath();
    final databaseFile = join(databasePath, 'user_database.db');

>>>>>>> 190e0d7 (updated code):lib/database.dart
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
<<<<<<< HEAD:lib/database_helper.dart

=======
>>>>>>> 190e0d7 (updated code):lib/database.dart
    return database!;
  }

  Future<void> insertUser(UserModel user) async {
    final db = await getDatabaseConnection();
<<<<<<< HEAD:lib/database_helper.dart

=======
>>>>>>> 190e0d7 (updated code):lib/database.dart
    await db.insert(
      'users',
      user.convertToMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

<<<<<<< HEAD:lib/database_helper.dart
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

=======

  Future<List<UserModel>> getAllUsers() async {
    final db = await getDatabaseConnection();
    final usersData = await db.query('users');
    return usersData.map((user) => UserModel.convertFromMap(user)).toList();
  }

  Future<UserModel?> checkLoginCredentials(String email, String password) async {
    final db = await getDatabaseConnection();
    final userData = await db.query
      ('users',
      where: 'email = ? AND password = ?',
      whereArgs: [email, password],
    );
>>>>>>> 190e0d7 (updated code):lib/database.dart
    if (userData.isNotEmpty) {
      return UserModel.convertFromMap(userData.first);
    }

    return null;
  }

<<<<<<< HEAD:lib/database_helper.dart

  Future<void> updateUserRecord(UserModel user) async {
    final db = await getDatabaseConnection();

=======
  Future<void> updateUserRecord(UserModel user) async {
    final db = await getDatabaseConnection();
>>>>>>> 190e0d7 (updated code):lib/database.dart
    await db.update(
      'users',
      user.convertToMap(),
      where: 'id = ?',
      whereArgs: [user.id],
    );
  }

  Future<void> deleteUserRecord(String id) async {
    final db = await getDatabaseConnection();
<<<<<<< HEAD:lib/database_helper.dart

=======
>>>>>>> 190e0d7 (updated code):lib/database.dart
    await db.delete(
      'users',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
