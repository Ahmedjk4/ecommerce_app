import 'package:electronics_shop/features/home/presentation/views/home_page_view.dart';
import 'package:electronics_shop/features/auth/presentation/views/login_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ControlFlow extends StatelessWidget {
  const ControlFlow({super.key});
  static const String id = "/controlFlow";
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return const HomePageView();
        } else {
          return const LoginView();
        }
      },
    );
  }
}
