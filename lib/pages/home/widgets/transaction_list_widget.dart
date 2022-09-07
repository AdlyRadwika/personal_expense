import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:empty_widget/empty_widget.dart';

import '../../../data/model/transaction.dart';
import '../../../utility/icon_util.dart';

import 'package:personal_expense/pages/home/widgets/update_delete_widget.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;

  const TransactionList({Key? key, required this.transactions})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return transactions.isEmpty
        ? Center(
            child: EmptyWidget(
              image: null,
              packageImage: PackageImage.Image_1,
              title: 'No Transaction!',
              subTitle: 'Start by adding a new transaction',
              titleTextStyle: Theme.of(context).textTheme.titleLarge,
              subtitleTextStyle: Theme.of(context).textTheme.bodyMedium,
            ),
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
                    child: InkWell(
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return Center(
                                child: FractionallySizedBox(
                                  alignment: Alignment.center,
                                  heightFactor: 0.25,
                                  widthFactor: 0.5,
                                  child: UpdateDeleteWidget(
                                    transactionId: transactions[index].id,
                                  ),
                                ),
                              );
                            });
                      },
                      child: ListTile(
                        leading: CircleAvatar(
                          radius: 30,
                          child: FittedBox(
                            child: Icon(IconUtil.getIconFromString(transactions[index].category)),
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
                            Text(transactions[index].category),
                            Text(DateFormat.yMMMd().format(transactions[index].date),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          );
  }
}