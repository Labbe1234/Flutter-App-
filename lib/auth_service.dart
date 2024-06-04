//    import 'package:firebase_auth/firebase_auth.dart';

// class AuthService {
//   final FirebaseAuth _auth = FirebaseAuth.instance;

//   Future<UserCredential?> signInWithEmailAndPassword(String email, String password) async {
//     try {
//       final credential = await _auth.signInWithEmailAndPassword(
//         email: email.trim(),
//         password: password.trim(),
//       );
//       return credential;
//     } catch (e) {
//       // Handle sign-in errors (e.g., display error message to user)
//       print(e.code); // For debugging purposes
//       return null;
//     }
//   }

//   Future<UserCredential?> signUpWithEmailAndPassword(String email, String password) async {
//     try {
//       final credential = await _auth.createUserWithEmailAndPassword(
//         email: email.trim(),
//         password: password.trim(),
//       );
//       return credential;
//     } catch (e) {
//       // Handle sign-up errors (e.g., display error message to user)
//       print(e.code); // For debugging purposes
//       return null;
//     }
//   }

//   // Add sign-out functionality if needed
//   Future<void> signOut() async {
//     await _auth.signOut();
//   }
// }
