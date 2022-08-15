import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:personal_expense/data/model/transaction.dart';
import 'package:personal_expense/pages/home/widgets/chart_bar_widget.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;

  const Chart({Key? key, required this.recentTransactions}) : super(key: key);

  List<Map<String, Object>> get groupedTransactionValues {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(
        Duration(days: 6 - index),
      );
      var totalSum = 0.0;

      for (var i = 0; i < recentTransactions.length; i++) {
        if (recentTransactions[i].date.day == weekDay.day
        && recentTransactions[i].date.month == weekDay.month
        && recentTransactions[i].date.year == weekDay.year) {
          totalSum += recentTransactions[i].amount;
        }
      }

      return {
        'day': DateFormat.E().format(weekDay).substring(0, 1),
        'amount': totalSum,
      };
    });
  }

  double get totalSpending {
    return groupedTransactionValues.fold(0.0, (sum, item) {
      return sum + (item['amount'] as double);
    });
  }

  @override
  Widget build(BuildContext context) {
    debugPrint(groupedTransactionValues.toString());
    return Card(
      elevation: 6,
      margin: const EdgeInsets.all(20),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupedTransactionValues.map((logs) {
            return Flexible(
              fit: FlexFit.tight,
              child: ChartBar(
                label: logs['day'] as String,
                spendingAmount: logs['amount'] as double,
                spendingPercentage:
                totalSpending == 0.0
                  ? 0.0
                  : (logs['amount'] as double) / totalSpending,
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}