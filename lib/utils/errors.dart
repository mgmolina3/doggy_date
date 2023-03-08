import 'package:firebase_auth/firebase_auth.dart';

const String defaultErrorMsg = 'Unable to process your request at this moment. Please try again later.';

String handleAuthError(FirebaseAuthException exception) {
  switch (exception.code) {
    case 'invalid-email':
      return 'Invalid email, please try again.';
    case 'user-not-found':
      return 'No user found for email and password. Please try again or create an account.';
    case 'wrong-password':
      return 'Incorrect password. Please try again.';
    case 'email-already-in-use':
      return 'An account already exists with that email. Please try again.';
    default:
      return 'Unable to process your request at this moment. Please try again later.';
  }
}

// String handleStoreError(FirebaseFirestoreException exception) {
//   switch (exception.code) {
//     case 'invalid-email':
//       return 'Invalid email, please try again.';
//     case 'user-not-found':
//       return 'No user found for email and password. Please try again or create an account.';
//     case 'wrong-password':
//       return 'Incorrect password. Please try again.';
//     case 'email-already-in-use':
//       return 'An account already exists with that email. Please try again.';
//     default:
//       return 'Unable to process your request at this moment. Please try again later.';
//   }
// }
