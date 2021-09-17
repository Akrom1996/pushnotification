import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:pushnotification/pages/signInPage.dart';
import 'package:pushnotification/services/prefsService.dart';

class AuthService {
  static final _auth = FirebaseAuth.instance;

  static Future<User?> signInUser(
      BuildContext context, String email, String password) async {
    try {
      _auth.signInWithEmailAndPassword(email: email, password: password);
      final User user = _auth.currentUser!;
      print(user.toString());
      return user;
    } catch (e) {
      print("error occured $e");

    }
    return null;
  }

  static Future<User?> signUpUser(
      BuildContext context, String name, String email, String password) async {
    try {

      var authResult = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User? user = authResult.user;
      print("userData: ${user.toString()}");
      return user;
    } catch (e) {
      print("error occured $e");
    }
    return null;
  }

  static void signOutUser(BuildContext context) async{
    // _auth.signOut();
    await _auth.currentUser!.delete();
    Prefs.removeUserId().then((value) {
      Navigator.pushReplacementNamed(context, SignIn.id);
    });
  }
}
