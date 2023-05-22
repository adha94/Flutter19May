// This is a Dart code for a Flutter mobile application that is used to register a user to the Junebank2u application. Below are comments on each section of the code:

// This section of the code imports all the necessary libraries to be used in the application.
import 'dart:core';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_application_1/homepage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'login_page.dart';

// The main() method initializes the Firebase app and runs the MyApp() widget.
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  runApp(MyApp(prefs: prefs));
}

// MyApp() is the root widget of the Flutter application. It defines the title of the application, the theme of the application, and sets the home widget to be RegistrationForm().
class MyApp extends StatelessWidget {
  final SharedPreferences prefs;
  const MyApp({super.key, required this.prefs});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final String? savedEmail = prefs.getString('email');
    final String? savedPassword = prefs.getString('password');
    bool isLogin = savedEmail != null && savedPassword != null;

    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Junebank2u App',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.yellow),
          useMaterial3: true,
        ),
        home: isLogin ? HomePage(savedEmail) : const LoginPage());
  }
}
