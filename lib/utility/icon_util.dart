import 'package:flutter/material.dart';
import 'package:personal_expense/data/model/transaction.dart';

class IconUtil {
  static IconData getIconFromString(String icon) {
    switch (icon) {
      case 'Snack':
        return Icons.icecream;
      case 'Food':
        return Icons.lunch_dining;
      case 'Drink':
        return Icons.local_cafe;
      case 'Laundry':
        return Icons.dry_cleaning;
      case 'Virtual Money':
        return Icons.attach_money;
      case 'Transportation':
        return Icons.commute;
      case 'Tools':
        return Icons.home_repair_service;
      case 'Bills':
        return Icons.receipt_long;
      case 'Subscription':
        return Icons.subscriptions;
      case 'Shopping':
        return Icons.shopping_cart;
      case 'Others':
        return Icons.menu;
      case 'Title':
        return Icons.title;
      default:
        return Icons.attach_money;
    }
  }

  static int getIconNumberFromString(String? icon) {
    for (int i = 0; i < categoryList.length; i++) {
      if (icon == categoryList[i].name) {
        return i;
      }
    }
    return -1;
  }
}
