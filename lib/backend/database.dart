import 'package:fetchingapp/model/data_model.dart';
import 'package:fetchingapp/backend/sql_queries.dart';
import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

Future<Database> cacheDatabase() async {
  return openDatabase(join(await getDatabasesPath(), 'cache_database.db'),
      onCreate: (db, version) {
    return db.execute(Queries().createCacheTable);
  }, version: 1);
}

//read data
Future<List<Map>> readCache() async {
  final db = await cacheDatabase();
  var cache = db.query('cache');
  cache.then((value) {
    print(value);
  });

  return cache;
}

// Future<List<Map>> readJsonCache() async {
//   final db = await cacheDatabase();
//   var cache = db.query('jsoncache');

//   return cache;
// }

Future insertSQLite({required Map<String, dynamic> item}) async {
  final db = await cacheDatabase();
  db.insert('cache', item);
}

Future insertBatchSQLite({required List<Map<String, dynamic>> list}) async {
  final db = await cacheDatabase();
  final batch = db.batch();
  for (var item in list) {
    batch.insert('cache', item, conflictAlgorithm: ConflictAlgorithm.replace);
  }
  await batch.commit(noResult: true);
}

Future updateSQLite({required Map<String, dynamic> item}) async {
  final db = await cacheDatabase();
  db.update('cache', item, where: 'doc_id = ?', whereArgs: [item['doc_id']]);
  // final batch = db.batch();
  // for (var item in list) {
  //   batch.insert('cache', item, conflictAlgorithm: ConflictAlgorithm.replace);
  // }
  // await batch.commit(noResult: true);
}

Future deleteSQLite({required Map<String, dynamic> item}) async {
  final db = await cacheDatabase();
  db.delete('cache', where: 'doc_id = ?', whereArgs: [item['doc_id']]);
}

// // add entry
// Future addBatchOfEntries({required List<dynamic> entries}) async {
//   final db = await cacheDatabase();
//   final batch = db.batch();
//   for (var item in entries) {
//     final entry =
//         DataModel(name: item['name'], body: item['body'], email: item['email']);

//     batch.insert('jsoncache', entry.toMap(),
//         conflictAlgorithm: ConflictAlgorithm.replace);
//   }
//   await batch.commit(noResult: true);
// }

Future cleanDB() async {
  // if (kIsWeb) {
  //   return;
  // }
  final db = await cacheDatabase();
  db.execute(Queries().dropCacheTable);
  // db.execute(Queries().dropJsonTable);
  db.execute(Queries().createCacheTable);
  // db.execute(Queries().jsonCache);
  // readCache();
}
