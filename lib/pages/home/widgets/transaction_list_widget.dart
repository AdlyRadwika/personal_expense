import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../data/model/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;

  const TransactionList({Key? key, required this.transactions})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 400,
      child: transactions.isEmpty
        ? Column(
        crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'There are no transactions!',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 20,),
              Flexible(
                child: Image.asset('assets/images/waiting.png'),
              ),
            ],
          )
        : ListView.builder(
            primary: false,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return Card(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "\$${transactions[index].amount.toStringAsFixed(2)}",
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          transactions[index].title,
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                        Text(
                          DateFormat.yMMMMd()
                              .add_jm()
                              .format(transactions[index].date),
                        ),
                      ],
                    )
                  ],
                ),
              );
            },
            itemCount: transactions.length,
          ),
    );
  }
}
