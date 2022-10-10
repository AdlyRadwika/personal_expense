import 'package:flutter/material.dart';
import 'package:personal_expense/widgets/input_transaction_modal_widget.dart';
import '../../../data/model/transaction.dart';
import 'package:personal_expense/data/database/transactions_database.dart';
import 'package:personal_expense/pages/home/widgets/add_button_widget.dart';
import 'package:personal_expense/pages/home/widgets/chart_widget.dart';
import 'package:personal_expense/widgets/transaction_item_widget.dart';

class HomePage extends StatefulWidget {
  final Transaction? transactions;

  const HomePage({Key? key, this.transactions}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late List<Transaction> _transactions = [];

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Personal Expense"),
      ),
      body: RefreshIndicator(
        onRefresh: () async => refreshTransactions(),
        child: Container(
          margin: const EdgeInsets.all(15),
          child: SingleChildScrollView(
            primary: true,
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(
              children: <Widget>[
                Chart(
                  recentTransactions: _sevenDaysTransaction,
                ),
                const SizedBox(
                  height: 12,
                ),
                TransactionItem(
                  isRecent: true,
                  transactions: _transactions,
                  inputTransactionModal: InputTransactionModal(
                          isUpdate: true, updateTransaction: _updateTransaction)
                      .build,
                  deleteTransaction: _deleteTransaction,
                  isLogs: false,
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        width: MediaQuery.of(context).size.width,
        child: AddButton(
            inputTransactionModal: InputTransactionModal(
          isUpdate: false,
          insertTransaction: _insertTransaction,
        ).build),
      ),
    );
  }

  refreshTransactions() async {
    _transactions = await TransactionsDb.instance.readAllTransactions();
    setState(() {});
  }

  List<Transaction> get _sevenDaysTransaction {
    return _transactions.where((tx) {
      return tx.date.isAfter(DateTime.now().subtract(const Duration(days: 7)));
    }).toList();
  }

  Future _insertTransaction(
      String title,
      double amount,
      DateTime chosenDate,
      String chosenCategory,
      String chosenDateMonth,
      int chosenDateYear,
      DateTime createdDate) async {
    final newTransaction = Transaction(
      title: title,
      amount: amount,
      date: chosenDate,
      category: chosenCategory,
      dateMonth: chosenDateMonth,
      dateYear: chosenDateYear,
      createdDate: createdDate,
    );

    await TransactionsDb.instance.createNewTransaction(newTransaction);
    refreshTransactions();
  }

  Future _updateTransaction(
    Transaction transaction,
    String updatedTitle,
    double updatedAmount,
    DateTime updatedDate,
    String updatedCategory,
    String updatedDateMonth,
    int updatedDateYear,
  ) async {
    final updatedTransaction = transaction.copy(
      title: updatedTitle,
      amount: updatedAmount,
      date: updatedDate,
      category: updatedCategory,
      dateMonth: updatedDateMonth,
      dateYear: updatedDateYear,
    );

    await TransactionsDb.instance.updateTransaction(updatedTransaction);
    refreshTransactions();
  }

  Future _deleteTransaction(int id) async {
    await TransactionsDb.instance.deleteTransaction(id);
    refreshTransactions();
  }
}
