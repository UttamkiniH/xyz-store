import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../ui/widgets/show_snackbar.dart';

class FirebaseAuthMedthods {
  final FirebaseAuth _auth;
  FirebaseAuthMedthods(this._auth);

  //*.state persistance//
  Stream<User?> get authState => FirebaseAuth.instance.authStateChanges();

  //* signup
  Future<void> signUpwithEmail(
      {required String userName,
      required String password,
      required String email,
      required BuildContext context}) async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);

      showSnackBar("Email Verification sent", context);
    } on FirebaseAuthException catch (e) {
      showSnackBar(e.message!, context);
    }
  }

  //* signin
  Future<void> signinEmail(
      {required String password,
      required String email,
      required BuildContext context}) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      showSnackBar(e.message!, context);
    }
  }

  //*.GOOGLE SIGN IN
  Future<void> signInWithGoogle(BuildContext context) async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      if (googleAuth?.accessToken != null && googleAuth?.idToken != null) {
        final credential = GoogleAuthProvider.credential(
            accessToken: googleAuth?.accessToken, idToken: googleAuth?.idToken);
        UserCredential userCredential =
            await _auth.signInWithCredential(credential);
      }
    } on FirebaseAuthException catch (e) {
      showSnackBar(e.message!, context);
    }
  }

  //sing out
  Future<void> signOut(BuildContext context) async {
    try {
      await _auth.signOut();
    } on FirebaseAuthException catch (e) {
      showSnackBar(e.message!, context);
    }
  }
}
