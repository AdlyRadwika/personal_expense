final String tableTransactions = 'transactions';

class TransactionFields {
  static final List<String> values = [
    id,
    title,
    amount,
    date,
    category,
    dateMonth,
    dateYear,
    createdDate
  ];

  static final String id = '_id';
  static final String title = 'title';
  static final String amount = 'amount';
  static final String date = 'date';
  static final String category = 'category';
  static final String dateMonth = 'date_month';
  static final String dateYear = 'date_year';
  static final String createdDate = 'created_date';
}

class Transaction {
  final int? id;
  final String title;
  final double amount;
  final DateTime date;
  final String category;
  final String dateMonth;
  final int dateYear;
  final DateTime createdDate;

  Transaction(
      {this.id,
      required this.title,
      required this.amount,
      required this.category,
      required this.dateMonth,
      required this.dateYear,
      required this.createdDate,
      required this.date});

  Transaction copy({
    int? id,
    String? title,
    double? amount,
    DateTime? date,
    String? category,
    String? dateMonth,
    int? dateYear,
    DateTime? createdDate,
  }) =>
      Transaction(
          id: id ?? this.id,
          title: title ?? this.title,
          amount: amount ?? this.amount,
          category: category ?? this.category,
          date: date ?? this.date,
          dateMonth: dateMonth ?? this.dateMonth,
          dateYear: dateYear ?? this.dateYear,
          createdDate: createdDate ?? this.createdDate);

  static Transaction fromJson(Map<String, Object?> json) => Transaction(
        id: json[TransactionFields.id] as int?,
        title: json[TransactionFields.title] as String,
        amount: json[TransactionFields.amount] as double,
        category: json[TransactionFields.category] as String,
        date: DateTime.parse(json[TransactionFields.date] as String),
        dateMonth: json[TransactionFields.dateMonth] as String,
        dateYear: json[TransactionFields.dateYear] as int,
        createdDate:
            DateTime.parse(json[TransactionFields.createdDate] as String),
      );

  Map<String, Object?> toJson() => {
        TransactionFields.id: id,
        TransactionFields.title: title,
        TransactionFields.amount: amount,
        TransactionFields.category: category,
        TransactionFields.date: date.toIso8601String(),
        TransactionFields.dateMonth: dateMonth,
        TransactionFields.dateYear: dateYear,
        TransactionFields.createdDate: createdDate.toIso8601String(),
      };
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
