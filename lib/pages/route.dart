import 'package:flutter/material.dart';

import 'package:personal_expense/pages/home/home.dart';
import '../widgets/transaction_list_widget.dart';
import 'package:personal_expense/pages/logs/logs.dart';


const homePage = 'home_page';
const logsPage = 'logs_page';

Route<dynamic> controller(RouteSettings settings) {
  switch (settings.name) {
    case homePage:
      return MaterialPageRoute(builder: (context) => const HomePage(),);
    case logsPage:
      LogsPageArguments arguments = settings.arguments as LogsPageArguments;
      return MaterialPageRoute(builder: (context) {
        return LogsPage(
          transactions: arguments.transactions,
          inputTransactionModal: arguments.inputTransactionModal,
          deleteTransaction: arguments.deleteTransaction,
        );
      });
    default:
      throw("Page is not found");
  }
}