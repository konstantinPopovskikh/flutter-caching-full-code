import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fetchingapp/backend/database.dart';
import 'package:flutter/material.dart';

class StreamFireStore extends StatefulWidget {
  const StreamFireStore({Key? key}) : super(key: key);

  @override
  _StreamFireStoreState createState() => _StreamFireStoreState();
}

class _StreamFireStoreState extends State<StreamFireStore> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Firestore Data'),
      ),
      body: Column(
        children: [
          
          Expanded(
            child: list(),
          ),
          inputfield(),
        ],
      ),
    );
  }
}

Widget inputfield() {
  final textController = TextEditingController();

  void addEntry() {
    if (textController.text == '') {
      return;
    }
    FirebaseFirestore.instance
        .collection('flutter-caching')
        .add({'name': textController.text});
    textController.clear();
  }

  return TextField(
      controller: textController,
      onEditingComplete: () {
        addEntry();
      },
      decoration: InputDecoration(
          prefixIcon: const Icon(Icons.add_circle),
          labelText: "Input new value and click Save:",
          suffixIcon: IconButton(
            icon: const Icon(Icons.save),
            splashColor: Colors.blue,
            tooltip: "Post message",
            onPressed: () {
              addEntry();
            },
          )));
}

Widget list() {
  return Center(
    child: StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('flutter-caching')
          .orderBy('name')
          .snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        } else {
          var data = snapshot.data!.docs.map((e) {
            return {'name': e['name']};
          }).toList();
          // addToSQLite(list: data);
          return ListView(
            children: snapshot.data!.docs.map((e) {
              return ListTile(
                title: Text(e['name']),
                trailing: IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () {
                    e.reference.delete();
                  },
                ),
              );
            }).toList(),
          );
        }
      },
    ),
  );
}
