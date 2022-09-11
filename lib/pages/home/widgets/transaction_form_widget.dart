import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../data/model/transaction.dart';
import 'package:personal_expense/utility/icon_util.dart';

import 'package:personal_expense/widget/text_field_widget.dart';
import 'package:personal_expense/pages/home/widgets/category_widget.dart';

class TransactionForm extends StatefulWidget {
  final Function? addTransaction;
  final Function? updateTransaction;
  final bool isUpdate;
  final Transaction? transactions;

  const TransactionForm({Key? key, this.addTransaction, this.updateTransaction, required this.isUpdate, this.transactions}) : super(key: key);

  @override
  State<TransactionForm> createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  late final _titleController = TextEditingController();
  late final _amountController = TextEditingController();
  late final _dateController = TextEditingController();
  final _inputKey = GlobalKey<FormState>();
  DateTime? _selectedDate;
  String? _dateText;
  late int _selectedCategoryPosition;
  bool _isCategoryEmpty = false;
  String? _formattedAmount;

  @override
  void initState() {
    super.initState();

    _titleController.text = widget.transactions?.title ?? '';
    _formattedAmount = NumberFormat.decimalPattern().format(widget.transactions?.amount ?? 0);
    _amountController.text =  zeroToNull(_formattedAmount)!;
    _selectedDate = widget.transactions?.date ?? DateTime.now();
    _dateText = DateFormat.yMd().format(_selectedDate!);
    _dateController.text = _dateText!;
    _selectedCategoryPosition = IconUtil.getIconNumberFromString(widget.transactions?.category);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  String? zeroToNull (String? str) {
    if (str == '0') {
      return '';
    }
    return str;
  }
  
  String? removeComma (String? str) {
    if(str!.isNotEmpty) {
      return str = str.replaceFirst(',', '');
    }
    return '';
  }

  void _submitData() {
    final titleValue = _titleController.text;
    final amountValue = double.parse(removeComma(_amountController.text)!);

    widget.isUpdate == true
    ? widget.updateTransaction!(
        widget.transactions,
        titleValue,
        amountValue,
        _selectedDate,
        categoryList[_selectedCategoryPosition].name,
      )
    : widget.addTransaction!(
        titleValue,
        amountValue,
        _selectedDate!,
        categoryList[_selectedCategoryPosition].name,
      );

    _titleController.clear();
    _amountController.clear();
    _selectedDate = null;
    _selectedCategoryPosition = -1;

    Navigator.of(context).pop();
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
      _dateText = DateFormat.yMd().format(_selectedDate!);
      _dateController.text = _dateText!;
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
                    isNumber: false,
                  ),
                  const SizedBox(height: 12,),
                  CustomTextField(
                    textEditingController: _amountController,
                    emptyWarning: "Input the amount",
                    hintText: "50,000",
                    icon: "Money",
                    labelText: "Amount",
                    isNumber: true,
                  ),
                  const SizedBox(height: 12,),
                  TextFormField(
                    onTap: () {
                      FocusScope.of(context).requestFocus(FocusNode());
                      _chooseDatePicker();
                    },
                    validator: (value) {
                      if (value == null) {
                        return 'Choose the date';
                      }
                      return null;
                    },
                    controller: _dateController,
                    readOnly: true,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: _selectedDate == null
                          ? Theme.of(context).unselectedWidgetColor
                          : Theme.of(context).colorScheme.primary,
                    ),
                    decoration: InputDecoration(
                      isDense: true,
                      enabledBorder: OutlineInputBorder(
                          borderRadius: const BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide(
                            color: _selectedDate == null
                                ? Theme.of(context).disabledColor
                                : Theme.of(context).colorScheme.primary
                          )
                      ),
                      prefixIcon: Icon(
                        Icons.date_range,
                        size: 26,
                        color: _selectedDate == null
                            ? Theme.of(context).unselectedWidgetColor
                            : Theme.of(context).colorScheme.primary,
                      ),
                      label: Text(
                        'Date',
                        style: TextStyle(
                          color: _selectedDate == null
                              ? Theme.of(context).unselectedWidgetColor
                              : Theme.of(context).colorScheme.primary,
                        ),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: const BorderRadius.all(Radius.circular(10)),
                        borderSide: BorderSide(
                          color: Theme.of(context).errorColor
                        )
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8,),
            Column(
              children: [
                Text( _isCategoryEmpty == false
                  ? "Category"
                  : "Choose the category!",
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
                  if (_inputKey.currentState!.validate() && _selectedCategoryPosition != -1) {
                    _submitData();
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text( widget.isUpdate == true
                            ? "Transaction has been updated!"
                            : "Transaction has been added!"
                          ),
                          behavior: SnackBarBehavior.floating,
                        ));
                  } else if (_selectedCategoryPosition == -1) {
                    _isCategoryEmpty = true;
                    setState(() {});
                  }
                },
                child: Text(widget.isUpdate == true
                  ? "Update Transaction"
                  : "Add Transaction"
                ))
          ],
        ),
      ),
    );
  }
}