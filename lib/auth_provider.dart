import 'package:flutter/material.dart';
import 'database_helper.dart';
import 'user_model.dart';

class AuthProvider with ChangeNotifier {
  DatabaseHelper dbHelper = DatabaseHelper();

  String inputEmail = '';
  String inputPassword = '';
  String alertMessage = '';
  bool isLoggingIn = false;

  void updateEmail(String email) {
    inputEmail = email.trim();
    alertMessage = '';
    notifyListeners();
  }

  void updatePassword(String password) {
    inputPassword = password.trim();
    alertMessage = '';
    notifyListeners();
  }


  Future<bool> verifyLogin() async {
    isLoggingIn = true;
    alertMessage = '';
    notifyListeners();

    UserModel? matchedUser = await dbHelper.checkLoginCredentials(inputEmail, inputPassword);

    isLoggingIn = false;
    if (matchedUser != null) {
      notifyListeners();
      return true;
    } else {
      alertMessage = 'Wrong email or password, please try again.';
      notifyListeners();
      return false;
    }
  }
}
