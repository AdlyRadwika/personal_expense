import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:personal_expense/pages/logs/widgets/input_sort_modal.dart';
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
  String? thisMonth;
  int? thisYear;

  @override
  void initState() {
    super.initState();
    _refreshTransactions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        floatHeaderSlivers: true,
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverAppBar(
              pinned: true,
              snap: true,
              floating: true,
              title: const Text('Logs'),
              bottom: Tab(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '$thisMonth, $thisYear',
                        style:
                            Theme.of(context).textTheme.titleMedium?.copyWith(
                                  color: Colors.white,
                                  fontSize: 18,
                                ),
                      ),
                      ElevatedButton.icon(
                        onPressed: () {
                          InputSortModal(getMonthAndYear: _refreshTransactions)
                              .build(context);
                        },
                        icon: const Icon(Icons.filter_alt),
                        label: const Text('Sort'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              Theme.of(context).colorScheme.secondary,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)),
                          elevation: 0,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ];
        },
        body: RefreshIndicator(
          onRefresh: () => _refreshTransactions(),
          child: SingleChildScrollView(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 0),
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
      ),
    );
  }

  Future _refreshTransactions([String? month, int? year]) async {
    thisMonth = DateFormat.MMMM().format(DateTime.now());
    thisYear = DateTime.now().year;
    month = month ?? thisMonth;
    year = year ?? thisYear;
    thisMonth = month;
    thisYear = year;

    _transactions = await TransactionsDb.instance
        .readTransactionByMonthAndYear(month!, year!);
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
    _refreshTransactions();
  }

  Future _deleteTransaction(int id) async {
    await TransactionsDb.instance.deleteTransaction(id);
    _refreshTransactions();
  }
}
