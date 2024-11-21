import 'dart:developer';
import 'package:electronics_shop/core/helpers/showSnackBar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginByEmailAndPasswordService {
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static Future<void> loginByEmailAndPassword(String email, String password,
      {required BuildContext context}) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found' && context.mounted) {
        showSnackBar(context, 'No user found for that email.');
      } else if (e.code == 'wrong-password' && context.mounted) {
        showSnackBar(context, 'Wrong password provided for that user.');
      }
      log(e.toString());
    }
  }
}
