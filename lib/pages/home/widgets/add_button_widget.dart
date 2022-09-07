import 'package:flutter/material.dart';

class AddButton extends StatelessWidget {
  final Function addNewTransaction;

  const AddButton({Key? key, required this.addNewTransaction}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => addNewTransaction(context),
      style: ElevatedButton.styleFrom(
        primary: Theme.of(context).colorScheme.secondary,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        elevation: 0,
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Text(
          "Add new transactions",
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
    );
  }
}