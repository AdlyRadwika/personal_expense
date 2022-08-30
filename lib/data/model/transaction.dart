class Transaction {
  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final String category;

  Transaction({
    required this.id,
    required this.title,
    required this.amount,
    required this.category,
    required this.date
  });
}

class TransactionCategory {
  final String name;

  TransactionCategory(this.name);
}

var categoryList = [
  TransactionCategory('Drink'),
  TransactionCategory('Food'),
  TransactionCategory('Snack'),
  TransactionCategory('Bill'),
  TransactionCategory('Laundry'),
  TransactionCategory('Transportation'),
  TransactionCategory('Tools'),
  TransactionCategory('Virtual Money'),
  TransactionCategory('Shopping'),
  TransactionCategory('Subscription'),
  TransactionCategory('Others'),
];