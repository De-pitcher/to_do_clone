class AuthException {
  static String? createUserException(String exception) {
    switch (exception) {
      case 'email-already-in-use':
        return 'This email cannot be used as a user already exist with this email';
      case 'invalid-email':
        return 'Email is invalid';
      case 'operation-not-allowed':
        return 'This action is invalid';
      case 'weak-password':
        return 'The password entered is not strong';
      default:
        return null;
    }
  }

  static String? signInException(String exception) {
    switch (exception) {
      case 'invalid-email':
        return 'Email is not valid';
      case 'user-disabled':
        return 'This user has been disabled. Contact support';
      case 'user-not-found':
        return 'This user does not exist';
      case 'wrong-password':
        return 'Incorrect password';
      default:
        return null;
    }
  }

  static String? passwordResetException(String exception) {
    switch (exception) {
      case 'auth/invalid-email':
        return 'Email is invalid';
      case 'auth/user-not-found':
        return 'User does not exist';
      default:
        return null;
    }
  }

  static String? confirmPasswordResetException(String exception) {
    switch (exception) {
      case 'expired-action-code':
        return 'Code entered has expired';
      case 'invalid-action-code':
        return 'This code is invalid';
      case 'user-disabled':
        return 'The user has been disabled.';
      case 'user-not-found':
        return 'This user does not exist';
      case 'weak-password':
        return 'Enter a strong password';
      default:
        return null;
    }
  }
}
