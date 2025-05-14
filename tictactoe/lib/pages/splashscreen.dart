import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tictactoe/colors/color.dart';
import 'package:tictactoe/pages/landing_page.dart';

class Splashscreen extends StatelessWidget {
  const Splashscreen({super.key});

  static var customFontWhite = GoogleFonts.coiny(
    textStyle: TextStyle(color: Colors.white, fontSize: 28, letterSpacing: 3),
  );

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 3), () {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => FirstPage()),
        (route) => false,
      );
    });
    return Scaffold(
      backgroundColor: Appcolor.primaryColor,
      body: Stack(
        children: [
          Center(child: Text('Tic-Tac-Toe Game', style: customFontWhite)),
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
