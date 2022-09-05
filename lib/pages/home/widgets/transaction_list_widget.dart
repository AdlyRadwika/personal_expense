import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../data/model/transaction.dart';
import '../../../utility/icon_util.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;

  const TransactionList(
      {Key? key, required this.transactions}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return transactions.isEmpty
        ? const Center(
          child: CircularProgressIndicator(),
        )
        : Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Recent Transactions",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  TextButton(
                    onPressed: () {
                      debugPrint("Hello");
                    },
                    child: const Text("View all"),
                  )
                ],
              ),
              ListView.builder(
                primary: false,
                shrinkWrap: true,
                itemCount: transactions.length <= 4 ? transactions.length : 4,
                key: const Key('test'),
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      leading: CircleAvatar(
                        radius: 30,
                        child: FittedBox(
                          child: Icon(
                            IconUtil.getIconFromString(transactions[index].category)
                          ),
                        ),
                      ),
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            transactions[index].title,
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                          Text(
                            NumberFormat.compactCurrency(locale: 'in_ID').format(transactions[index].amount),
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                        ],
                      ),
                      subtitle: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            transactions[index].category
                          ),
                          Text(
                            DateFormat.yMMMd().format(transactions[index].date),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          );
  }
}