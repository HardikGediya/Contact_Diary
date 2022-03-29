import 'dart:async';

import 'package:flutter/material.dart';

import 'models/contact_models.dart';
import 'screens/add_ContactPage.dart';
import 'screens/contact_details_page.dart';
import 'screens/edit_ContactPage.dart';
import 'screens/homePage.dart';


void main() {
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    super.initState();
    Timer.periodic(const Duration(milliseconds: 100), (timer) {
      setState(() {});
    });
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: const TextTheme(
            bodyMedium: TextStyle(
              color: Colors.white,
            ),
          bodySmall: TextStyle(
            color: Colors.black,
          ),
          bodyLarge: TextStyle(
            color: Color(0xffe3D3fd),
          ),
          displayLarge:  TextStyle(
            color: Color(0xff0c58cf),
          ),
        ),
      ),

      darkTheme: ThemeData(
        scaffoldBackgroundColor: Colors.black,
        brightness: Brightness.dark,
        textTheme: const TextTheme(
            bodyMedium: TextStyle(
              color: Colors.black,
            ),
          bodySmall: TextStyle(
            color: Colors.white,
          ),
          bodyLarge: TextStyle(
            color: Color(0xff0c58cf),
          ),
          displayLarge:  TextStyle(
            color: Color(0xffe3D3fd),
          ),
        ),
      ),
      themeMode: (light) ? ThemeMode.light : ThemeMode.dark,
      routes: {
        '/' : (context) => const HomePage(),
        'add_contact_page' : (context) => const AddContactPage(),
        'edit_contact_page' : (context) => const EditContactPage(),
        'contacts_details' : (context) => const ContactsDetails(),
      },
    );
  }
}







