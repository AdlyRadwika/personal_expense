import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addTransaction;

  const NewTransaction({Key? key, required this.addTransaction}) : super(key: key);

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _selectedDate;

  void _submitData() {
    final enteredTitle = _titleController.text;
    final enteredAmount = double.parse(_amountController.text);

    if (enteredTitle.isEmpty || enteredAmount <= 0 || _selectedDate == null) {
      return; //to prevent from submitting
    }

    widget.addTransaction(
      enteredTitle,
      enteredAmount,
      _selectedDate!,
    );

    _titleController.clear();
    _amountController.clear();
    _selectedDate = null;
  }

  void _chooseDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2022),
      lastDate: DateTime.now()
    ).then((value) {
      if (value == null) {
        return;
      }
      _selectedDate = value;
      setState(() {});
    });
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
              controller: _titleController,
              onSubmitted: (value) => _submitData(),
              decoration: const InputDecoration(
                labelText: "Title",
              ),
            ),
            TextField(
              controller: _amountController,
              keyboardType: TextInputType.number,
              onSubmitted: (value) => _submitData(),
              decoration: const InputDecoration(
                labelText: "Amount",
              ),
            ),
            SizedBox(
              height: 70,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text( _selectedDate == null
                    ? 'mm/dd/yyyy'
                    : "Picked date: ${DateFormat.yMd().format(_selectedDate!)}"
                  ),
                  TextButton(
                    onPressed: _chooseDatePicker,
                    style: TextButton.styleFrom(
                      primary: Theme.of(context).colorScheme.primary
                    ),
                    child: const Text(
                      'Choose Date',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                ],
              ),
            ),
            ElevatedButton(
                onPressed: _submitData,
                child: const Text("Add Transaction"))
          ],
        ),
      ),
    );
  }
}