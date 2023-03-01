import "package:firebase_auth/firebase_auth.dart";
import '../exceptions/auth_exception.dart';

class Authentication {
  static final FirebaseAuth _auth = FirebaseAuth.instance;

  static User? user;

  static Future<String?> createAccount(String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      return null;
    } on FirebaseAuthException catch (e) {
      return AuthException.createUserException(e.code);
    }
  }

  static Future<String?> loginUser(String email, String password) async {
    try {
      await _auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) => user = value.user);
      return null;
    } on FirebaseAuthException catch (error) {
      return AuthException.signInException(error.code);
    }
  }

  static Future<String?> resetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      return null;
    } on FirebaseAuthException catch (err) {
      return AuthException.passwordResetException(err.code);
    }
  }

  static Future<String?> confirmPasswordReset(
      String code, String newPassword) async {
    try {
      await _auth.confirmPasswordReset(code: code, newPassword: newPassword);
      return null;
    } on FirebaseAuthException catch (e) {
      return AuthException.confirmPasswordResetException(e.code);
    }
  }

  static bool isSignedIn() {
    return user != null ? true : false;
  }

  Future signOut() async {
    await _auth.signOut();
  }
}
