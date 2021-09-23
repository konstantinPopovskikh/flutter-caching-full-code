import 'package:fetchingapp/backend/google_authentication.dart';
import 'package:fetchingapp/screens/home.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    // FirebaseService().signOutFromGoogle();
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Login Screen'),
      ),
      body: Center(
        child: googleLoginButton(context: context),
      ),
    );
  }
}

Widget googleLoginButton({required BuildContext context}) {
  void click() async {
    await FirebaseService().signInwithGoogle().then((user) {
      Navigator.push(
          context, MaterialPageRoute(builder: (_) => HomePage(user)));
    });
  }

  return OutlinedButton(
      style: OutlinedButton.styleFrom(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(45))),
      onPressed: click,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Image(image: AssetImage('images/google_logo.png'), height: 35),
            Padding(
                padding: EdgeInsets.only(left: 10),
                child: Text('Sign in with Google',
                    style: TextStyle(color: Colors.grey, fontSize: 25)))
          ],
        ),
      ));
}
