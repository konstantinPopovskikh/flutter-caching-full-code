import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fetchingapp/backend/database.dart';
import 'package:flutter/foundation.dart';

class FirestoreChanges extends ChangeNotifier {
  List<Map<String, dynamic>> list = [];
  Map<String, dynamic> map = {};
  bool isFirstBoot = true;

  void listenOnFirestoreChanges() {
    FirebaseFirestore.instance
        .collection('flutter-caching')
        .snapshots()
        .listen((event) {
      if (isFirstBoot) {
        cleanDB();
        for (var change in event.docChanges) {
          map = {'name': change.doc.data()!['name'], 'doc_id': change.doc.id};
          list.add(map);
        }
        print('first boot');
        print(list);
        insertBatchSQLite(list: list);
        isFirstBoot = false;
      } else {
        for (var change in event.docChanges) {
          map = {'name': change.doc.data()!['name'], 'doc_id': change.doc.id};
          if (change.type == DocumentChangeType.added) {
            insertSQLite(item: map);
          } else if (change.type == DocumentChangeType.modified) {
            updateSQLite(item: map);
          } else if (change.type == DocumentChangeType.removed) {
            deleteSQLite(item: map);
          }
          print('Change type: ${change.type};\n'
              'Doc ID: ${change.doc.id}\n'
              'Data: ${change.doc.data()}\n\n');
        }
      }
      // notifyListeners();
    });
  }
}


