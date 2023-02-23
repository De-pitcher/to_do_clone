import "package:firebase_auth/firebase_auth.dart";

class Authentication {
  static final FirebaseAuth _auth = FirebaseAuth.instance;

  FirebaseAuth get auth => _auth;

  static User? user;

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
      await _auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) => user = value.user);
      return null;
    } on FirebaseAuthException catch (error) {
      return "${error.code} : ${error.message}";
    }
  }

  static Future<String?> resetPassword(String newPassword,
      [String? code]) async {
    try {
      if (user != null) {
        await _auth
            .sendPasswordResetEmail(email: user!.email!)
            .then((value) async {
          // try {
          //   await _auth.confirmPasswordReset(
          //       code: code!, newPassword: newPassword);
          //   return null;
          // } on FirebaseAuthException catch (e) {
          //   switch (e.code) {
          //     case 'expired-action-code':
          //       return 'Code entered has expired';
          //     case 'invalid-action-code':
          //       return 'This code is invalid';
          //     case 'user-disabled':
          //       return 'The user has been disabled.';
          //     case 'user-not-found':
          //       return 'This user does not exist';
          //     case 'weak-password':
          //       return 'Enter a strong password';
            
          //   }
          // }
    
        });
      }
      return null;
    } on FirebaseAuthException catch (err) {
      if (err.code == 'auth/invalid-email') {
        return 'Email is invalid';
      } else if (err.code == 'auth/user-not-found') {
        return 'User does not exist';
      }
    }
  }

  static bool isSignedIn() {
    return user != null ? true : false;
  }

  Future signOut() async {
    await _auth.signOut();
  }
}
