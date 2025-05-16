import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tictactoe/pages/firebase_auth/auth_service.dart';
import 'package:tictactoe/pages/first_screens/splashscreen.dart';
import 'package:tictactoe/pages/tools/app_loading.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: authService.value.authStateChanges,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return AppLoadingPage();
        } else if (snapshot.hasData) {
          return Splashscreen();
        } else {
          return Splashscreen();
        }
      },
    );
  }
}
