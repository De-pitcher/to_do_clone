import "package:firebase_auth/firebase_auth.dart";

class Authentication {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future createAccount(
      {required String email, required String password}) async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
    } catch (e) {
      print(e.toString());
    }
  }

  Future loginUser(String email, String password) async {
    await _auth.signInWithEmailAndPassword(email: email, password: password);
  }

  bool isSignedIn() {
    var signedIn = _auth.currentUser != null ? true : false;
    return signedIn;
  }

  Future signOut() async {
    await _auth.signOut();
  }
}
