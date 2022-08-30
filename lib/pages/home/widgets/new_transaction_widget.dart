import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../data/model/transaction.dart';
import 'package:personal_expense/pages/home/widgets/category_widget.dart';
import 'package:personal_expense/widget/text_field_widget.dart';

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
  int _selectedCategoryPosition = -1;

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
      categoryList[_selectedCategoryPosition].name,
    );

    _titleController.clear();
    _amountController.clear();
    _selectedDate = null;
    _selectedCategoryPosition = -1;
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
          children: [
            Form(
              key: _inputKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                children: [
                  CustomTextField(
                    textEditingController: _titleController,
                    emptyWarning: "Input the title",
                    hintText: "Bought new game",
                    icon: "Title",
                    labelText: "Title",
                  ),
                  const SizedBox(height: 12,),
                  CustomTextField(
                    textEditingController: _amountController,
                    emptyWarning: "Input the amount",
                    hintText: "50.000",
                    icon: "Money",
                    labelText: "Amount",
                    isNumber: true,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 1,
                      color: _selectedDate == null
                        ? Theme.of(context).disabledColor
                        : Theme.of(context).colorScheme.primary
                    ),
                    borderRadius: const BorderRadius.all(Radius.circular(5)),
                  ),
                  child: Text( _selectedDate == null
                    ? _dateText = 'mm/dd/yyyy'
                    : _dateText = DateFormat.yMd().format(_selectedDate!),
                    style: TextStyle(
                      color: _selectedDate == null
                        ? Theme.of(context).unselectedWidgetColor
                        : Theme.of(context).colorScheme.primary
                    ),
                  ),
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
            const SizedBox(height: 8,),
            Column(
              children: [
                Text(
                  "Category",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                SizedBox(
                  height: 65,
                  child: ListView.builder(
                    itemCount: categoryList.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      final TransactionCategory selectedCategory = categoryList[index];
                      return Row(
                        children: [
                          CategoryWidget(
                            isSelected: _selectedCategoryPosition == index,
                            selectedCategory: selectedCategory,
                            itemPosition: index,
                            onAreaClicked: (position) {
                              _selectedCategoryPosition = index;
                              setState(() {});
                            },
                          ),
                          const SizedBox(width: 8,),
                        ],
                      );
                    },
                  ),
                )
              ],
            ),
            const SizedBox(height: 12,),
            ElevatedButton(
                onPressed: () {
                  if (_inputKey.currentState!.validate() && _dateText != "mm/dd/yyyy" && _selectedCategoryPosition != -1) {
                    _submitData();
                    ScaffoldMessenger.of(widget.bottomSheetContext).showSnackBar(
                        const SnackBar(
                          content: Text("Transaction has been added!"),
                          behavior: SnackBarBehavior.floating,
                        ));
                  } else if (_dateText == "mm/dd/yyyy"){
                    ScaffoldMessenger.of(widget.bottomSheetContext).showSnackBar(
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