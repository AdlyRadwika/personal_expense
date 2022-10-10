import 'package:flutter/material.dart';
import '../../data/database/transactions_database.dart';
import '../../data/model/transaction.dart';
import 'package:personal_expense/widgets/transaction_item_widget.dart';
import '../../widgets/input_transaction_modal_widget.dart';

class LogsPage extends StatefulWidget {
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
  State<LogsPage> createState() => _LogsPageState();
}

class _LogsPageState extends State<LogsPage> {
  late List<Transaction> _transactions = [];

  @override
  void initState() {
    super.initState();

    refreshTransactions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Logs',
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async => refreshTransactions(),
        child: Container(
          margin: const EdgeInsets.all(15),
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(
              children: [
                TransactionItem(
                  isRecent: false,
                  transactions: _transactions,
                  inputTransactionModal: InputTransactionModal(
                    isUpdate: true,
                    updateTransaction: _updateTransaction,
                  ).build,
                  deleteTransaction: _deleteTransaction,
                  isLogs: true,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  refreshTransactions() async {
    _transactions = await TransactionsDb.instance.readAllTransactions();
    setState(() {});
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
