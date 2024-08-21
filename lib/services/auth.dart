import 'package:firebase_auth/firebase_auth.dart';

class AuthServices {
  ///Login
  Future<User?> login({required String email, required String password}) async {
    UserCredential userCredential = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
    return userCredential.user;
  }

  ///SignUp
  Future<User?> signUp(
      {required String email, required String password}) async {
    UserCredential userCredential = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
    userCredential.user!.sendEmailVerification();
    return userCredential.user;
  }

  ///Forgot Password
  Future forgotPassword(String email) async {
    return await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
  }
}
