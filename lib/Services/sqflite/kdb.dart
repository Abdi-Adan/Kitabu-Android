import 'package:sqflite/sqflite.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'models.dart';

class DBHelper {
  static DBHelper _dbHelper;
  static Database _database;

  String creditorTable = 'cdb';
  String creditorID = 'id';
  String creditorName = 'name';
  String creditorNo = 'phone';
  String cDate = 'date';

  String itemDB = 'idb';
  String itemID = 'itemid';
  String price = 'price';
  String qty = 'qty';
  String itemName = 'iname';

  DBHelper._createInstance();

  factory DBHelper() {
    if (_dbHelper == null) {
      _dbHelper = DBHelper._createInstance();
    }
    return _dbHelper;
  }

  Future<Database> get database async {
    if (_database == null) {
      _database = await initializeDatabase();
    }

    return _database;
  }

  Future<Database> initializeDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + 'kdb.db';

    var kitabuDatabase =
        await openDatabase(path, version: 1, onCreate: _onCreateDB);
    return kitabuDatabase;
  }

  void _onCreateDB(Database db, int newVersion) async {
    await db.execute(
        'CREATE TABLE $creditorTable($creditorID INTEGER PRIMARY KEY AUTOINCREMENT, $creditorName TEXT, $creditorNo TEXT, $cDate TEXT)');
    await db.execute(
        'CREATE TABLE $itemDB($itemID INTEGER PRIMARY KEY AUTOINCREMENT, $creditorID INTEGER FOREIGN KEY, $itemName TEXT, $price INTEGER, $qty INTEGER)');
  }

  //Fetch all records
  Future<List<Map<String, dynamic>>> getItemList() async {
    Database db = await this.database;

    var itemList = await db.query(itemDB, orderBy: '$itemName');
    return itemList;
  }

  Future<List<Map<String, dynamic>>> getCustomerList() async {
    Database db = await this.database;

    var customerList = await db.query(creditorTable, orderBy: '$creditorName');
    return customerList;
  }

  //Insert new debt
  Future<int> insertDebtItem(Items items) async {
    Database db = await this.database;
    var result = await db.insert(itemDB, items.toMap());
    return result;
  }

  //New Customer
  Future<int> insertCreditor(Creditor creditor) async {
    Database db = await this.database;
    var result = await db.insert(creditorTable, creditor.toMap());
    return result;
  }

  //Update both creditor and items
  Future<int> updateCreditor(Creditor creditor) async {
    Database db = await this.database;
    var result = await db.update(creditorTable, creditor.toMap(),
        where: '$creditorID = ?', whereArgs: [creditor.creditorId]);

    return result;
  }

  Future<int> updateItems(Items items) async {
    Database db = await this.database;
    var result = await db.update(itemDB, items.toMap(),
        where: '$itemID = ?', whereArgs: [items.id]);

    return result;
  }

  Future<int> deleteItem(int id) async {
    var db = await this.database;

    int result = await db.rawDelete('DELETE FROM $itemDB WHERE $itemID = $id');

    return result;
  }

  Future<int> deleteCreditor(int id) async {
    var db = await this.database;

    int result = await db
        .rawDelete('DELETE FROM $creditorTable WHERE $creditorID = $id');

    return result;
  }

  //object count
  Future<int> getObjectCount() async {
    Database db = await this.database;
    List<Map<String, dynamic>> x =
        await db.rawQuery('SELECT COUNT (*) FROM $creditorTable');
    int result = Sqflite.firstIntValue(x);
    return result;
  }

  Future<int> getObjCount() async {
    Database db = await this.database;
    List<Map<String, dynamic>> x =
        await db.rawQuery('SELECT COUNT (*) FROM $itemDB');
    int result = Sqflite.firstIntValue(x);
    return result;
  }
}
