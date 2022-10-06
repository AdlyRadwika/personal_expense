import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import '../data/model/transaction.dart';
import 'transaction_form_widget.dart';

class InputTransactionModal {
  final bool isUpdate;
  final Transaction? transaction;
  final Function? updateTransaction;
  final Function? insertTransaction;

  const InputTransactionModal(
      {required this.isUpdate,
      this.transaction,
      this.updateTransaction,
      this.insertTransaction});

  void build(BuildContext context, bool isUpdate, [Transaction? transaction]) {
    showMaterialModalBottomSheet(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15), topRight: Radius.circular(15))),
      isDismissible: true,
      enableDrag: true,
      bounce: true,
      backgroundColor: Colors.white,
      context: context,
      builder: (builderContext) {
        return Wrap(
          children: [
            isUpdate == true
                ? TransactionForm(
                    isUpdate: true,
                    updateTransaction: updateTransaction,
                    transactions: transaction,
                  )
                : TransactionForm(
                    isUpdate: false,
                    addTransaction: insertTransaction,
                  )
          ],
        );
      },
    );
  }
}
