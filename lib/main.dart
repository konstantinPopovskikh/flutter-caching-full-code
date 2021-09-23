import 'package:fetchingapp/backend/firestore_listener.dart';
import 'package:fetchingapp/backend/notifications.dart';
import 'package:fetchingapp/screens/home.dart';
import 'package:fetchingapp/screens/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  initializeMessaging();
  // listenOnFirestoreChanges();

  var token = await FirebaseMessaging.instance.getToken();
  print('FCM token: $token');

  runApp(ChangeNotifierProvider(
    create: (_) => FirestoreChanges(),
    child: const MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    handleMessagesAndroid();
  }

  @override
  Widget build(BuildContext context) {
    User? firebaseUser = FirebaseAuth.instance.currentUser;

    Widget firstScreen;

    if (firebaseUser != null) {
      firstScreen = HomePage(firebaseUser);
    } else {
      firstScreen = const LoginPage();
    }

    Provider.of<FirestoreChanges>(context, listen: false)
        .listenOnFirestoreChanges();

    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: firstScreen,
    );
  }
}
