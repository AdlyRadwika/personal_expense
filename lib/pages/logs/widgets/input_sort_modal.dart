import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:personal_expense/pages/logs/widgets/sort_form_widget.dart';

class InputSortModal {
  final Function getMonthAndYear;

  const InputSortModal({required this.getMonthAndYear});

  void build(BuildContext context) {
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
            SortForm(
              setMonthAndYear: getMonthAndYear,
            ),
          ],
        );
      },
    );
  }
}
