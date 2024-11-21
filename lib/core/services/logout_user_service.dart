import 'package:firebase_auth/firebase_auth.dart';

class LogoutUserService {
  static Future<void> logoutUser() async {
    await FirebaseAuth.instance.signOut();
  }
}