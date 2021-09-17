import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pushnotification/services/authService.dart';
import 'package:pushnotification/services/prefsService.dart';

class SignUp extends StatefulWidget {
  static final String id = "signup";
  const SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController textEditingController1 = TextEditingController();
  TextEditingController textEditingController2 = TextEditingController();
  TextEditingController textEditingController3 = TextEditingController();

  Future SingUpUser() async {
    var user = await AuthService.signUpUser(
        context,
        textEditingController1.text,
        textEditingController2.text,
        textEditingController3.text);

    if (user != null) {
      Prefs.saveUserId(user.uid);
      Navigator.pop(context);
    } else {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Text("error"),
        ),
      );
    }
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
              decoration: InputDecoration(hintText: "Email"),
            ),
            SizedBox(
              height: 16,
            ),
            TextField(
              controller: textEditingController3,
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
                  await SingUpUser();
                },
                child: Text("Sign Up"),
              ),
            ),
            SizedBox(
              height: 32,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text("Have already an account? "),
                TextButton(
                  onPressed: () async {
                    Navigator.pop(context);
                  },
                  child: Text("Sign in"),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
