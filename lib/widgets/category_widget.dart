import 'package:flutter/material.dart';

import 'package:personal_expense/data/model/transaction.dart';
import 'package:personal_expense/utility/icon_util.dart';

class CategoryWidget extends StatelessWidget {
  final bool isSelected;
  final TransactionCategory selectedCategory;
  final int itemPosition;
  final Function(int position) onAreaClicked;

  const CategoryWidget(
      {Key? key,
      required this.isSelected,
      required this.selectedCategory,
      required this.itemPosition,
      required this.onAreaClicked})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      onPressed: () {
        onAreaClicked(itemPosition);
      },
      style: OutlinedButton.styleFrom(
        foregroundColor: isSelected
            ? Theme.of(context).colorScheme.primary
            : Theme.of(context).unselectedWidgetColor,
        side: BorderSide(
            color: isSelected
                ? Theme.of(context).colorScheme.primary
                : Theme.of(context).disabledColor),
      ),
      icon: Icon(IconUtil.getIconFromString(selectedCategory.name)),
      label: Text(selectedCategory.name),
    );
  }
}
