import "package:firebase_auth/firebase_auth.dart";
import 'package:flutter/widgets.dart';

class Authentication {
  static final FirebaseAuth _auth = FirebaseAuth.instance;

  FirebaseAuth get auth => _auth;

  static Future<String?> createAccount(String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      return null;
    } on FirebaseAuthException catch (e) {
      return "${e.code} : ${e.message}";
    }
  }

  static Future<String?> loginUser(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      return null;
    } on FirebaseAuthException catch (error) {
      return "${error.code} : ${error.message}";
    }
  }

  static bool isSignedIn() {
    return _auth.currentUser != null ? true : false;
  }

  resetPassword(String newPassword) async {
    await _auth.sendPasswordResetEmail(email: _auth.currentUser!.email!);
  }

  Future signOut() async {
    await _auth.signOut();
  }
}
