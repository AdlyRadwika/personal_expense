import 'package:flutter/material.dart';

import 'package:personal_expense/pages/route.dart' as route;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personal Expense',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.teal,
          accentColor: Colors.deepOrangeAccent,
          errorColor: Colors.redAccent,
        ),
        fontFamily: 'Quicksand',
        appBarTheme: const AppBarTheme(
          titleTextStyle: TextStyle(
            fontFamily: 'OpenSans',
            fontSize: 20,
            fontWeight: FontWeight.bold,
          )
        ),
        textTheme: const TextTheme(
          titleSmall: TextStyle(
            fontFamily: 'OpenSans',
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
          titleMedium: TextStyle(
            fontFamily: 'OpenSans',
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
          titleLarge: TextStyle(
            fontFamily: 'OpenSans',
            fontSize: 26,
            fontWeight: FontWeight.bold,
          ),
          headlineMedium: TextStyle(
            fontFamily: 'OpenSans',
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        )
      ),
      onGenerateRoute: route.controller,
      initialRoute: route.homePage,
    );
  }
}