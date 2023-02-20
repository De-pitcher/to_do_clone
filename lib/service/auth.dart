import "package:firebase_auth/firebase_auth.dart";

class Authentication {
  static final FirebaseAuth _auth = FirebaseAuth.instance;

  FirebaseAuth get auth => _auth;

  Future<String> createAccount(
      {required String email, required String password}) async {
    String? error;
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
    } catch (e) {
      error = e.toString();
    }

    return error!;
  }

  Future<String> loginUser(String email, String password) async {
    String? err;
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);

    } on FirebaseAuthException catch (error) {
      err = error.message;
      print(error.message);
    }
    return err!;
  }

  bool isSignedIn() {
    var signedIn = _auth.currentUser != null ? true : false;
    return signedIn;
  }

  Future signOut() async {
    await _auth.signOut();
  }
}
