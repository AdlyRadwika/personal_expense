import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addTransaction;
  final BuildContext bottomSheetContext;

  const NewTransaction({Key? key, required this.addTransaction, required this.bottomSheetContext}) : super(key: key);

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  final _inputKey = GlobalKey<FormState>();
  DateTime? _selectedDate;
  String? _dateText;

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  void _submitData() {
    final enteredTitle = _titleController.text;
    final enteredAmount = double.parse(_amountController.text);

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
    return Container(
      padding: const EdgeInsets.all(16),
      child: Padding(
        padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Form(
              key: _inputKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                children: [
                  TextFormField(
                    controller: _titleController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Input the title';
                      }
                      return null;
                    },
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500
                    ),
                    decoration: const InputDecoration(
                      isDense: true,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10))
                      ),
                      hintText: 'Bought new game',
                      prefixIcon: Icon(Icons.title),
                      labelText: "Title",
                    ),
                  ),
                  const SizedBox(height: 12,),
                  TextFormField(
                    controller: _amountController,
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Input the amount';
                      }
                      return null;
                    },
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500
                    ),
                    decoration: const InputDecoration(
                      isDense: true,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10))
                      ),
                      hintText: '50.000',
                      prefixIcon: Icon(Icons.attach_money),
                      labelText: "Amount",
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12,),
            SizedBox(
              height: 70,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text( _selectedDate == null
                    ? _dateText = 'mm/dd/yyyy'
                    : _dateText = "Picked date: ${DateFormat.yMd().format(_selectedDate!)}",
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
                onPressed: () {
                  if (_inputKey.currentState!.validate() && _dateText != "mm/dd/yyyy") {
                    _submitData();
                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Transaction has been added!"),
                          behavior: SnackBarBehavior.floating,
                        ));
                  } else if (_dateText == "mm/dd/yyyy"){
                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Choose the date!"),
                          behavior: SnackBarBehavior.floating,
                        ));
                  }
                },
                child: const Text("Add Transaction"))
          ],
        ),
      ),
    );
  }
}