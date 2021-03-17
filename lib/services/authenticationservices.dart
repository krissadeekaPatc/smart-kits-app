import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationServices {
  FirebaseAuth _firebaseAuth;

  Future<Null> signIn(String email, String password) async {
    await _firebaseAuth
        .signInWithEmailAndPassword(email: email, password: password)
        .then((result) {
      print("signed in ${result.user.email}");
    }).catchError((error) {
      print(error);
    });
  }

  Future<Null> signUp(String email, String password) async {
    await _firebaseAuth
        .createUserWithEmailAndPassword(
      email: email,
      password: password,
    )
        .then((result) {
      result.user.getIdToken().then((value) {
        print(value);
      });
    }).catchError((onError) {
      print(onError);
    });
  }
}
