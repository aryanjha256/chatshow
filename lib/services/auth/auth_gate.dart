import 'package:chatshow/services/auth/login_or_register.dart';
import 'package:chatshow/pages/home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instanceFor(
          app: FirebaseAuth.instance.app,
        ).authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasData) {
            return HomePage();
          } else {
            return const LoginOrRegister();
          }
        },
      ),
    );
  }
}
