import 'package:electronics_shop/core/helpers/showSnackBar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChangeNameService {
  static Future<void> changeName(BuildContext context, String name) async {
    try {
      await FirebaseAuth.instance.currentUser!.updateDisplayName(name);
    } catch (e) {
      if (context.mounted) {
        showSnackBar(context, "Error Changing Name");
      }
    }
  }
}
