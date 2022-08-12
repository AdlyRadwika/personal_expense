import 'package:flutter/material.dart';

class NewTransaction extends StatefulWidget {
  final Function(String title, double amount) addTransaction;

  const NewTransaction({Key? key, required this.addTransaction}) : super(key: key);

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();
  final amountController = TextEditingController();

  void submitData() {
    final enteredTitle = titleController.text;
    final enteredAmount = double.parse(amountController.text);

    if (enteredTitle.isEmpty || enteredAmount <= 0) {
      return; //to prevent from submitting
    }

    widget.addTransaction(
      enteredTitle,
      enteredAmount,
    );

    titleController.clear();
    amountController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextField(
              controller: titleController,
              onSubmitted: (value) => submitData(),
              decoration: const InputDecoration(
                labelText: "Title",
              ),
            ),
            TextField(
              controller: amountController,
              keyboardType: TextInputType.number,
              onSubmitted: (value) => submitData(),
              decoration: const InputDecoration(
                labelText: "Amount",
              ),
            ),
            ElevatedButton(
                onPressed: submitData,
                child: const Text("Add Transaction"))
          ],
        ),
      ),
    );
  }
}