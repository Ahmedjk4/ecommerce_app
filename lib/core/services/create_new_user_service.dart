import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CreateNewUserService {
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static Future<void> createNewUser({
    required String name,
    required String phoneNumber,
    required String email,
    required String password,
  }) async {
    try {
      await _auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((UserCredential user) {
        _auth.currentUser!.updateDisplayName(name);
        _auth.currentUser!.updatePhotoURL(
            'https://ui-avatars.com/api/?background=random&name=$name&format=png&size=256');
        _firestore.collection('users').doc(email).set(
          {
            'name': name,
            'email': email,
            'phoneNumber': phoneNumber,
            'role': 'user',
            'updatedInfo': false,
          },
        );
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        log('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        log('The account already exists for that email.');
      }
    } catch (e) {
      log(e.toString());
    }
  }
}
