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
        primarySwatch: Colors.blue,
      ),
      onGenerateRoute: route.controller,
      initialRoute: route.homePage,
    );
  }
}