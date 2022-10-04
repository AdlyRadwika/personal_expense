import 'package:flutter/material.dart';

import '../../data/model/transaction.dart';

import 'package:personal_expense/widgets/transaction_item_widget.dart';

class LogsPage extends StatelessWidget {
  final List<Transaction> transactions;
  final Function inputTransactionModal;
  final Function deleteTransaction;

  const LogsPage(
      {Key? key,
      required this.transactions,
      required this.inputTransactionModal,
      required this.deleteTransaction})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Logs',
        ),
      ),
      body: Container(
        margin: const EdgeInsets.all(15),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TransactionItem(
                isRecent: false,
                transactions: transactions,
                inputTransactionModal: inputTransactionModal,
                deleteTransaction: deleteTransaction,
              )
            ],
          ),
        ),
      ),
    );
  }
}
