import 'package:flutter/material.dart';

import '../../../data/model/transaction.dart';

import 'package:personal_expense/pages/home/widgets/chart_widget.dart';
import 'package:personal_expense/pages/home/widgets/transaction_list_widget.dart';
import 'package:personal_expense/pages/home/widgets/new_transaction_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final titleController = TextEditingController();
  final amountController = TextEditingController();

  final List<Transaction> _userTransaction = [
    // Transaction(
    //   id: 't1',
    //   title: 'New Clothes',
    //   amount: 43.12,
    //   date: DateTime.now(),
    // ),
    // Transaction(
    //   id: 't2',
    //   title: 'New Toys',
    //   amount: 59.34,
    //   date: DateTime.now(),
    // ),
  ];
  
  List<Transaction> get _recentTransactions {
    return _userTransaction.where((tx) {
      return tx.date.isAfter(
        DateTime.now().subtract(const Duration(days: 7))
      );
    }).toList();
  }

  void _addNewTransaction(String title, double amount, DateTime chosenDate){
    final newTransaction = Transaction(
        id: DateTime.now().hashCode.toString(),
        title: title,
        amount: amount,
        date: chosenDate,
    );
    setState(() {
      _userTransaction.add(newTransaction);
    });
  }

  void _startAddNewTransaction(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (builderContext) {
        return NewTransaction(
          addTransaction: _addNewTransaction,
        );
      },
    );
  }

  void _deleteTransaction(String id) {
    setState(() {
      _userTransaction.removeWhere((element) => element.id == id);
    });
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
        padding: const EdgeInsets.all(8),
        child: Column(
          children: <Widget> [
            Chart(
              recentTransactions: _recentTransactions,
            ),
            Expanded(
              child: TransactionList(
                transactions: _userTransaction,
                deleteTx: _deleteTransaction,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _startAddNewTransaction(context),
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}