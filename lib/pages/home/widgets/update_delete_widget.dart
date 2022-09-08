import 'package:flutter/material.dart';

import 'package:personal_expense/data/database/transactions_database.dart';
import 'package:personal_expense/data/model/transaction.dart';

import 'package:personal_expense/pages/route.dart' as route;

class UpdateDeleteWidget extends StatefulWidget {
  final int? transactionId;
  final Function inputTransaction;
  final Transaction? transactions;

  const UpdateDeleteWidget({Key? key, required this.transactionId, required this.inputTransaction, this.transactions}) : super(key: key);

  @override
  State<UpdateDeleteWidget> createState() => _UpdateDeleteWidgetState();
}

class _UpdateDeleteWidgetState extends State<UpdateDeleteWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Theme.of(context).dialogBackgroundColor,
          borderRadius: const BorderRadius.all(Radius.circular(15))
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();

                const isUpdate = true;
                widget.inputTransaction(context, isUpdate, widget.transactions);
              },
              child: const Text("Update"),
            ),
            ElevatedButton(
              onPressed: () async {
                await TransactionsDb.instance.deleteTransaction(widget.transactionId!);

                if(!mounted) return;

                Navigator.of(context).pushNamedAndRemoveUntil(route.homePage, (route) => false);

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Delete success!"),
                    behavior: SnackBarBehavior.floating,
                  )
                );
              },
              child: const Text("Delete"),
            ),
          ],
        ),
      );
  }
}