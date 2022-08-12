import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:personal_expense/data/model/transaction.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;

  const Chart({Key? key, required this.recentTransactions}) : super(key: key);

  List<Map> groupedAmountLastWeek() {
    List<double> lastWeekAmounts = this.lastWeekAmounts();

    return List.generate(7, (index) {
      return {
        'day': DateHelper.weekDayTimeAgo(days: index),
        'amount': lastWeekAmounts[index],
      };
    });
  }


  List<double> lastWeekAmounts() {
    final DateTime now = DateTime.now();
    List<double> result = [0, 0, 0, 0, 0, 0, 0];

    for (int i = 0; i < recentTransactions.length; i++) {
      int daysAgo = now.difference(recentTransactions[i].executionDate).inDays;
      if (daysAgo <= 6) {
        result[daysAgo] += recentTransactions[i].amount;
      }
    }

    for (int j = 0; j < result.length; j++) {
      result[j] = NumericHelper.roundDouble(result[j], 2);
    }

    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      child: Row(
        children: [

        ],
      ),
    );
  }
}
