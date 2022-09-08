import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../../../data/model/transaction.dart';
import 'package:personal_expense/data/database/transactions_database.dart';

import 'package:personal_expense/pages/home/widgets/add_button_widget.dart';
import 'package:personal_expense/pages/home/widgets/chart_widget.dart';
import 'package:personal_expense/pages/home/widgets/transaction_list_widget.dart';
import 'package:personal_expense/pages/home/widgets/new_transaction_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late List<Transaction> _userTransaction = [];

  @override
  void initState() {
    super.initState();

    refreshTransactions();
  }

  @override
  void dispose() {
    TransactionsDb.instance.close();

    super.dispose();
  }

  refreshTransactions() async {
    _userTransaction = await TransactionsDb.instance.readAllTransactions();
    setState(() {});
  }

  List<Transaction> get _recentTransactions {
    return _userTransaction.where((tx) {
      return tx.date.isAfter(
        DateTime.now().subtract(const Duration(days: 7))
      );
    }).toList();
  }

  Future _addNewTransaction(String title, double amount, DateTime chosenDate, String chosenCategory) async {
    final newTransaction = Transaction(
        title: title,
        amount: amount,
        date: chosenDate,
        category: chosenCategory,
    );

    await TransactionsDb.instance.createNewTransaction(newTransaction);
    refreshTransactions();
  }

  void _startAddNewTransaction(BuildContext context) {
    showMaterialModalBottomSheet(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15)
        )
      ),
      isDismissible: true,
      enableDrag: true,
      bounce: true,
      backgroundColor: Colors.white,
      context: context,
      builder: (builderContext) {
        return Wrap(
            children: [
              NewTransaction(
                addTransaction: _addNewTransaction,
                bottomSheetContext: builderContext,
              ),
            ],
          );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Personal Expense"),
        actions: [
          IconButton(
            onPressed: () => _startAddNewTransaction(context),
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(15),
        child: SingleChildScrollView(
          primary: true,
          child: Column(
            children: <Widget> [
              Chart(
                recentTransactions: _recentTransactions,
              ),
              const SizedBox(height: 12,),
              TransactionList(
                transactions: _userTransaction,
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar:Container(
        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        width: MediaQuery.of(context).size.width,
        child: AddButton(addNewTransaction: _startAddNewTransaction),
      ),
    );
  }
}