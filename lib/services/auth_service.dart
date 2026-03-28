import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // signup
  Future<User?> signUp(String email, String password) async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
              email: email,
              password: password);

      return userCredential.user;
    } catch (e) {
      print(e);
      return null;
    }
  }

  // login
  Future<User?> signIn(String email, String password) async {
    try {
      UserCredential userCredential =
          await _auth.signInWithEmailAndPassword(
              email: email,
              password: password);

      return userCredential.user;
    } catch (e) {
      print(e);
      return null;
    }
  }

  // logout
  Future<void> signOut() async {
    await _auth.signOut();
  }
}