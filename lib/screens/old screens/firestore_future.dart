import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fetchingapp/backend/api.dart';
import 'package:flutter/material.dart';

class FutureFireStore extends StatefulWidget {
  const FutureFireStore({Key? key}) : super(key: key);

  @override
  _FutureFireStoreState createState() => _FutureFireStoreState();
}

class _FutureFireStoreState extends State<FutureFireStore> {
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
          inputField(),
        ],
      ),
    );
  }
}

Widget list() {
  return Center(
    child: FutureBuilder(
        future: ApiProvider().getDataForFirestore(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          } else {
            // return Text(snapshot.data.toString());
            return ListView.builder(
                itemCount: (snapshot.data as dynamic).length,
                itemBuilder: (context, index) {
                  final entry = (snapshot.data as dynamic)[index];
                  return ListTile(
                    title: Text(entry['name'].toString()),
                    leading: const Icon(Icons.data_usage),
                  );
                });
          }
        }),
  );
}

Widget inputField() {
  final textController = TextEditingController();

  void addEntry() {
    // if (textController.text == '') {
    //   return;
    // }
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
