import 'package:flutter/material.dart';

import 'package:personal_expense/data/model/transaction.dart';

class UpdateDeleteWidget extends StatefulWidget {
  final int? transactionId;
  final Function updateTransaction;
  final Function deleteTransaction;
  final Transaction? transactions;

  const UpdateDeleteWidget(
      {Key? key,
      required this.transactionId,
      required this.updateTransaction,
      this.transactions,
      required this.deleteTransaction})
      : super(key: key);

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
          borderRadius: const BorderRadius.all(Radius.circular(15))),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();

              const isUpdate = true;
              widget.updateTransaction(context, isUpdate, widget.transactions);
            },
            child: const Text("Update"),
          ),
          ElevatedButton(
            onPressed: () async {
              Navigator.of(context).pop();

              widget.deleteTransaction(widget.transactionId);

              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text("Transaction has been deleted!"),
                behavior: SnackBarBehavior.floating,
              ));
            },
            child: const Text("Delete"),
          ),
        ],
      ),
    );
  }
}
