import "package:firebase_auth/firebase_auth.dart";

class Authentication {
  FirebaseAuth instance = FirebaseAuth.instance;

  Future createAccount(
      {required String email, required String password}) async {
    await instance.createUserWithEmailAndPassword(
        email: email, password: password);
  }

  Future loginUser(String email, String password) async {
    await instance.signInWithEmailAndPassword(email: email, password: password);
  }
}
