import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:pushnotification/pages/signUpPage.dart';
import 'package:pushnotification/services/authService.dart';
import 'package:pushnotification/services/prefsService.dart';

import 'homePage.dart';

class SignIn extends StatefulWidget {
  static final String id = "signIn";
  const SignIn({Key? key}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  TextEditingController textEditingController1 = TextEditingController();
  TextEditingController textEditingController2 = TextEditingController();
  Future signIn() async {
    User? user = await AuthService.signInUser(
      context,
      textEditingController1.text,
      textEditingController2.text,
    );
   await Prefs.loadUserId() == user!.uid
        ? Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (_) => HomePage(),
            ),
          )
        : showDialog(
            context: context,
            builder: (_) => AlertDialog(
                  title: Text("error"),
                ));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: textEditingController1,
              decoration: InputDecoration(hintText: "Fullname"),
            ),
            SizedBox(
              height: 16,
            ),
            TextField(
              controller: textEditingController2,
              decoration: InputDecoration(hintText: "Password"),
            ),
            SizedBox(
              height: 16,
            ),
            Container(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.red,
                ),
                onPressed: () async {
                  await signIn();
                },
                child: Text("Sign In"),
              ),
            ),
            SizedBox(
              height: 32,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text("Don't have an account? "),
                TextButton(
                  onPressed: () async {
                    // AuthService.signOutUser(context);
                    Navigator.pushNamed(context, SignUp.id);
                  },
                  child: Text("Sign Up"),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
