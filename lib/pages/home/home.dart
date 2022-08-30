import 'package:flutter/material.dart';

import '../../../data/model/transaction.dart';

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
  final List<Transaction> _userTransaction = [];
  
  List<Transaction> get _recentTransactions {
    return _userTransaction.where((tx) {
      return tx.date.isAfter(
        DateTime.now().subtract(const Duration(days: 7))
      );
    }).toList();
  }

  void _addNewTransaction(String title, double amount, DateTime chosenDate, String chosenCategory){
    final newTransaction = Transaction(
        id: DateTime.now().hashCode.toString(),
        title: title,
        amount: amount,
        date: chosenDate,
        category: chosenCategory,
    );
    setState(() {
      _userTransaction.add(newTransaction);
    });
  }

  void _startAddNewTransaction(BuildContext context) {
    showModalBottomSheet(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15)
        )
      ),
      backgroundColor: Colors.white,
      context: context,
      isScrollControlled: true,
      builder: (builderContext) {
        return Scaffold(
          body: Wrap(
            children: [
              NewTransaction(
                addTransaction: _addNewTransaction,
                bottomSheetContext: builderContext,
              ),
            ],
          ),
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