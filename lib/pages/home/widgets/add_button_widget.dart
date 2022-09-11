import 'package:flutter/material.dart';

class AddButton extends StatelessWidget {
  final Function inputTransactionModal;

  const AddButton({Key? key, required this.inputTransactionModal}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        const bool isUpdate = false;
        inputTransactionModal(context, isUpdate);
      },
      style: ElevatedButton.styleFrom(
        primary: Theme.of(context).colorScheme.secondary,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        elevation: 0,
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Text(
          "Add new transaction",
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
    );
  }
}