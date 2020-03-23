// import 'dart:io';
// import 'dart:async';
// import 'package:path/path.dart';
// import 'package:sqflite/sqflite.dart';
// import 'package:path_provider/path_provider.dart';

// import 'models.dart';

// class DatabaseClient {
//   Database _db;

//   Future create() async {
//     Directory path = await getApplicationDocumentsDirectory();
//     String dbPath = join(path.path, "kitabu.db");

//     _db = await openDatabase(dbPath, version: 1, onCreate: this._create);
//   }

//   Future _create(Database db, int version) async {
//     // Creditor Table
//     await db.execute("""
//     CREATE TABLE creditors(
//       creditorId INTEGER PRIMARY KEY,
//       creditorName TEXT,
//       creditorPhoneNo INT,
//     )""");
//     // item tables
//     await db.execute("""
//         CREATE TABLE items (
//            id INTEGER PRIMARY KEY,
//            userid INTEGER NOT NULL,
//            priceq INTEGER NOT NULL,
//            quantity INTEGER  NOT NULL,
//            itemname NOT NULL,
//            FOREIGN KEY(userid) REFERENCES creditor(creditorId)
//             ON UPDATE CASCADE
//             ON DELETE CASCADE
//     """);
//   }

//   Future<Creditor> upsertCreditor(Creditor creditor) async {
//     var count = Sqflite.firstIntValue(await _db.rawQuery(
//         "SELECT COUNT(*) FROM creditor WHERE creditorName = ?",
//         [creditor.creditorName]));
//     if (count == 0) {
//       creditor.creditorId = await _db.insert("creditor", creditor.toMap());
//     } else {
//       await _db.update("creditor", creditor.toMap(),
//           where: "creditorId = ?", whereArgs: [creditor.creditorId]);
//     }
//     return creditor;
//   }

//   Future<Items> upsertItems(Items items) async {
//     if (items.id == null) {
//       items.id = await _db.insert("items", items.toMap());
//     } else {
//       await _db.update("items", items.toMap(),
//           where: "id = ?", whereArgs: [items.id]);
//     }
//     return items;
//   }

//   Future<Creditor> fetchCreditor(int creditorId) async {
//     List<Map> results = await _db.query("creditor",
//         columns: Creditor.columns,
//         where: "creditorId = ?",
//         whereArgs: [creditorId]);

//     Creditor creditor = Creditor.fromMap(results[0]);

//     return creditor;
//   }

//   Future<Items> fetchItems(int id) async {
//     List<Map> results = await _db.query("Items",
//         columns: Items.columns, where: "id = ?", whereArgs: [id]);

//     Items items = Items.fromMap(results[0]);

//     return items;
//   }

//   // Future<List<Items>> fetchlatestItems(int limit) async{
//   //   List<Map> results = await _db.query("items", columns: Items.columns, limit: limit, orderBy: "id DESC");

//   //   List<Items> Items = new List();
//   //   results.forEach((result) {
//   //     Items Items = Items.fromMap(result);
//   //     Items.add(Items);
//   //   });

//   //   return Items;
//   // }

//   Future<Items> fetchItemsandCreditor(int creditorId) async {
//     List<Map> results = await _db.query("items",
//         columns: Items.columns,
//         where: "creditorId = ?",
//         whereArgs: [creditorId]);

//     Items items = Items.fromMap(results[0]);
//     items.creditor = await fetchCreditor(creditorId);

//     return items;
//   }
// }
