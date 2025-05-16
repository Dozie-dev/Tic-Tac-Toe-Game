import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tictactoe/colors/color.dart';
import 'package:tictactoe/pages/first_screens/landing_page.dart';
import 'package:tictactoe/pages/first_screens/welcome_page.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  static var customFontWhite = GoogleFonts.coiny(
    textStyle: TextStyle(color: Colors.white, fontSize: 28, letterSpacing: 3),
  );

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  @override
  void initState() {
    super.initState();
    _checkUserData();
  }

  void _checkUserData() async {
    final user = FirebaseAuth.instance.currentUser;
    final hasDisplayName =
        user?.displayName != null && user!.displayName!.isNotEmpty;

    if (hasDisplayName) {
      Future.delayed(Duration(seconds: 4), () {
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => FirstPage()),
          (route) => false,
        );
      });
    } else {
      Future.delayed(Duration(seconds: 4), () {
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => WelcomePage()),
          (route) => false,
        );
      });
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Appcolor.primaryColor,
      body: Stack(
        children: [
          Center(
            child: Text(
              'Tic-Tac-Toe Game',
              style: Splashscreen.customFontWhite,
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(left: 30.0, right: 30, bottom: 20),
              child: LinearProgressIndicator(
                value: null,
                backgroundColor: Colors.white,
                color: Appcolor.primaryColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
