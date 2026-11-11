import 'package:flutter/material.dart';
import 'database_helper.dart';
import 'user_model.dart';

class RegistrationProvider with ChangeNotifier {
  DatabaseHelper dbHelper = DatabaseHelper();
  List<UserModel> savedUsersList = [];
  bool isPageLoading = false;

  Future<void> fetchAndRefreshUsers() async {
    isPageLoading = true;
    notifyListeners();

    savedUsersList = await dbHelper.getAllUsers();

    isPageLoading = false;
    notifyListeners();
  }

  Future<void> createNewUser(UserModel user) async {
    await dbHelper.insertUser(user);
    await fetchAndRefreshUsers();
  }

  Future<void> modifyUser(UserModel user) async {
    await dbHelper.updateUserRecord(user);
    await fetchAndRefreshUsers();
  }

  Future<void> deleteUser(String id) async {
    await dbHelper.deleteUserRecord(id);
    await fetchAndRefreshUsers();
  }
}
