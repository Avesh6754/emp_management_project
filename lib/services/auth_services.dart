import 'package:firebase_auth/firebase_auth.dart';

class AuthServices {
  AuthServices._();

  static AuthServices authServices = AuthServices._();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<String> createAccount(
      {required String email, required String password}) async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
    } catch (e) {
      return "error";
    }
    return "create";
  }

  Future<String> signIn(
      {required String email, required String password}) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
    } catch (e) {
      return "error";
    }
    return "create";
  }

  User? currentUser() {
    User? user = _auth.currentUser;
    return user;
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }
}
