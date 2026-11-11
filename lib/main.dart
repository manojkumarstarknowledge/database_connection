import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'auth_provider.dart';
import 'registration_provider.dart';
import 'login_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyDatabaseApp());
}

class MyDatabaseApp extends StatelessWidget {
  const MyDatabaseApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthProvider()),
        ChangeNotifierProvider(create: (context) => RegistrationProvider()..fetchAndRefreshUsers()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Persistent Registration App',
        theme: ThemeData(primarySwatch: Colors.blue),
        home: LoginScreen(),
      ),
    );
  }
}
