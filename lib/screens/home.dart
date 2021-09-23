import 'package:fetchingapp/backend/database.dart';
import 'package:fetchingapp/backend/google_authentication.dart';
import 'package:fetchingapp/screens/firestore_collection.dart';
import 'package:fetchingapp/screens/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage(this.user, {Key? key}) : super(key: key);

  final User user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Home Screen'),
      ),
      body: Column(
        children: [
          userProfileCard(context: context, user: user),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => const FirestoreCollectionCaching()));
              },
              child: const Text(
                'Firestore Collection',
                style: TextStyle(fontSize: 25),
              )),
          ElevatedButton(
              onPressed: () {
                readCache();
              },
              child: const Text('Read Cache'))
        ],
      ),
    );
  }
}

Widget userProfileCard({required BuildContext context, required User user}) {
  return Card(
    child: ListTile(
      leading: const Icon(Icons.person),
      title: Text(user.displayName.toString()),
      subtitle: Text(user.email.toString()),
      trailing: IconButton(
          onPressed: () {
            FirebaseService().signOutFromGoogle();
            Navigator.push(
                context, MaterialPageRoute(builder: (_) => const LoginPage()));
          },
          icon: const Icon(Icons.logout)),
    ),
    elevation: 8,
  );
}
