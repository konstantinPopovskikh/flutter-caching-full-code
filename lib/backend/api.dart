import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fetchingapp/backend/database.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart' show kIsWeb;

class ApiProvider {
  // final url = 'https://jsonplaceholder.typicode.com/comments';

  // Future getData() async {
  //   if (kIsWeb) {
  //     return _getFromApi();
  //   }
  //   return _getFromDB();
  // }

  Future getDataForFirestore() async {
    return readCache().then((value) async {
      if (value.isNotEmpty) {
        print('READING FROM DB, NUMBER OF ENTRIES: ${value.length}');
        callFirestore();
        return value;
      } else {
        return callFirestore();
      }
    });
  }

  Future callFirestore() async {
    cleanDB();
    print('fetching from network');
    var data = await FirebaseFirestore.instance
        .collection('flutter-caching')
        .orderBy('name')
        .get();
    var array = data.docs.map((e) {
      return {'name': e['name']};
    }).toList();
    // await insertSQLite(list: array);
    return array;
  }

  // Future _getFromDB() async {
  //   return readJsonCache().then((value) {
  //     if (value.isNotEmpty) {
  //       print('reading from db');
  //       return value;
  //     } else {
  //       print('fetching from network');
  //       return _getFromApi();
  //     }
  //   });
  // }

//   Future _getFromApi() async {
//     try {
//       final req = await http.get(Uri.parse(url));
//       if (req.statusCode == 200) {
//         final body = req.body;
//         final jsonDecoded = json.decode(body);

//         // cache data
//         if (!kIsWeb) {
//           await cleanDB();
//           await addBatchOfEntries(entries: jsonDecoded);
//         }
//         return json.decode(body);
//       } else {
//         return json.decode(req.body);
//       }
//     } catch (e) {
//       // ignore
//     }
//   }
// }
}
