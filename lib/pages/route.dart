import 'package:flutter/material.dart';

import 'package:personal_expense/pages/home/home.dart';
import 'package:personal_expense/pages/update/update.dart';

const homePage = 'home_page';
const updatePage = 'update_page';

Route<dynamic> controller(RouteSettings settings) {
  switch (settings.name) {
    case homePage:
      return MaterialPageRoute(builder: (context) => const HomePage(),);
    case updatePage:
      return MaterialPageRoute(builder: (context) => const UpdatePage(),);
    default:
      throw("Page is not found");
  }
}