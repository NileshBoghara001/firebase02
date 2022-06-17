import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Auth {
  //Object
  FirebaseAuth _auth = FirebaseAuth.instance;

  void singUP(String e1, String p1) {
    _auth.createUserWithEmailAndPassword(email: e1, password: p1);
  }

  void signIN(String e1, String p1, BuildContext context) {
    _auth
        .signInWithEmailAndPassword(email: e1, password: p1)
        .then((value) => Navigator.pushNamed(context, "/home"));
  }

  bool currentUser(BuildContext context) {
    if (_auth.currentUser != null) {
      // login success
      return true;
    } else {
      // login failed
      return false;
    }
  }

  void signOut(BuildContext context) {
    _auth.signOut().whenComplete(() => Navigator.pushNamed(context, '/'));
  }

  void googleSingIn(BuildContext context) async {
    // Open Google Dialog
    GoogleSignInAccount? googleSignInAccount = await GoogleSignIn().signIn();

    //Select Id
    GoogleSignInAuthentication gsa = await googleSignInAccount!.authentication;

    //Data creadatial
    var credatial = GoogleAuthProvider.credential(accessToken: gsa.accessToken,idToken: gsa.idToken);

    //Login
    _auth.signInWithCredential(credatial).whenComplete(() => Navigator.pushNamed(context, '/home'));

  }
}







