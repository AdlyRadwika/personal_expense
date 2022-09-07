import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'package:personal_expense/data/model/transaction.dart' as tx;

class TransactionsDb {
  static final TransactionsDb instance = TransactionsDb._init();

  static Database? _database;

  TransactionsDb._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('transactions.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    final idType = 'INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL';
    final doubleType = 'DOUBLE NOT NULL';
    final textType = 'TEXT NOT NULL';

    await db.execute('''
      CREATE TABLE ${tx.tableTransactions}(
        ${tx.TransactionFields.id} $idType,
        ${tx.TransactionFields.title} $textType,
        ${tx.TransactionFields.amount} $doubleType,
        ${tx.TransactionFields.date} $textType,
        ${tx.TransactionFields.category} $textType
      )
    ''');
  }

  Future<tx.Transaction> createNewTransaction(tx.Transaction transaction) async {
    final db = await instance.database;

    final id = await db.insert(tx.tableTransactions, transaction.toJson());
    return transaction.copy(id: id);
  }

  Future<tx.Transaction> readTransaction(int id) async {
    final db = await instance.database;

    final maps = await db.query(
      tx.tableTransactions,
      columns: tx.TransactionFields.values,
      where: '${tx.TransactionFields.id} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty){
      return tx.Transaction.fromJson(maps.first);
    } else {
      throw Exception('ID $id is not found');
    }
  }

  Future<List<tx.Transaction>> readAllTransactions() async {
    final db = await instance.database;

    final orderBy = '${tx.TransactionFields.date} ASC';
    final result = await db.query(tx.tableTransactions, orderBy: orderBy);

    return result.map((json) => tx.Transaction.fromJson(json)).toList();
  }

  Future<int> updateTransaction(tx.Transaction transaction) async {
    final db = await instance.database;

    return db.update(
      tx.tableTransactions,
      transaction.toJson(),
      where: '${tx.TransactionFields.id} = ?',
      whereArgs: [transaction.id],
    );
  }

  Future<int> deleteTransaction(int id) async {
    final db = await instance.database;

    return await db.delete(
      tx.tableTransactions,
      where: '${tx.TransactionFields.id} = ?',
      whereArgs: [id],
    );
  }

  Future close() async{
    final db = await instance.database;
    _database = null;
    db.close();
  }
}