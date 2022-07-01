// ignore_for_file: file_names, prefer_const_declarations, depend_on_referenced_packages

import 'package:banking_app/model/customer.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:banking_app/model/transaction.dart';

class CustomerDatabase {
  static final CustomerDatabase instance = CustomerDatabase._init();
  static Database? _database;
  CustomerDatabase._init();
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('customers.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    final idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    final textType = 'TEXT NOT NULL';
    final integerType = 'INTEGER NOT NULL';

    await db.execute('''
CREATE TABLE $tableName ( 
  ${TableFields.id} $idType, 
  ${TableFields.name} $textType,
  ${TableFields.value} $integerType
  )
''');
    await db.execute('''
CREATE TABLE $transactionTable (
  ${TransactionTableField.id} $idType, 
  ${TransactionTableField.value} $textType
  )
''');

    Customer c1 = Customer(customerName: "Wahaj", moneyValue: 50000);
    Customer c2 = Customer(customerName: "Javed", moneyValue: 50000);
    Customer c3 = Customer(customerName: "Alam", moneyValue: 50000);
    Customer c4 = Customer(customerName: "Elliot", moneyValue: 50000);
    Customer c5 = Customer(customerName: "Alderson", moneyValue: 50000);
    Customer c6 = Customer(customerName: "Mr.robot", moneyValue: 50000);
    Customer c7 = Customer(customerName: "Goku", moneyValue: 50000);
    Customer c8 = Customer(customerName: "Vegeta", moneyValue: 50000);
    Customer c9 = Customer(customerName: "Homelander", moneyValue: 50000);
    Customer c10 = Customer(customerName: "Light", moneyValue: 50000);
    await db.insert(tableName, c1.toJson());
    await db.insert(tableName, c2.toJson());
    await db.insert(tableName, c3.toJson());
    await db.insert(tableName, c4.toJson());
    await db.insert(tableName, c5.toJson());
    await db.insert(tableName, c6.toJson());
    await db.insert(tableName, c7.toJson());
    await db.insert(tableName, c8.toJson());
    await db.insert(tableName, c9.toJson());
    await db.insert(tableName, c10.toJson());
  }

  Future insertTransaction(TransactionList transaction) async {
    final db = await instance.database;
    await db.insert(transactionTable, transaction.toJson());
  }

  Future<Customer> readData(int id) async {
    final db = await instance.database;

    final maps = await db.query(
      tableName,
      columns: TableFields.values,
      where: '${TableFields.id} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return Customer.fromJson(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  Future<List<Customer>> readAllData() async {
    final db = await instance.database;
    final result = await db.query(tableName);
    return result.map((json) => Customer.fromJson(json)).toList();
  }

  Future<List<TransactionList>> readAllTransactions() async {
    final db = await instance.database;
    final result = await db.query(transactionTable);
    if (result.isEmpty) {
      return [];
    } else {
      return result.map((json) => TransactionList.fromJson(json)).toList();
    }
  }

  Future<int> update(Customer customer) async {
    final db = await instance.database;

    return db.update(
      tableName,
      customer.toJson(),
      where: '${TableFields.id} = ?',
      whereArgs: [customer.id],
    );
  }

  Future close() async {
    final db = await instance.database;

    db.close();
  }
}
