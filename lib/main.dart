import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'authentication_provider.dart';
import 'registration_provider.dart';
import 'login_screen.dart';

void main() {
  runApp(MyDatabaseApp());
}

class MyDatabaseApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthProvider()),
        ChangeNotifierProvider(create: (context) {
          RegistrationProvider provider = RegistrationProvider();
          provider.fetchAndRefreshUsers();
          return provider;
        }),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Registration App',
        home: LoginScreen(),
      ),
    );
  }
}
