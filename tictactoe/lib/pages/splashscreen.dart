import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tictactoe/colors/color.dart';

class Splashscreen extends StatelessWidget {
  const Splashscreen({super.key});

  static var customFontWhite = GoogleFonts.coiny(
    textStyle: TextStyle(color: Colors.white, fontSize: 28, letterSpacing: 3),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Appcolor.primaryColor,
      body: Center(child: Text('Tic-Tac-Toe Game', style: customFontWhite)),
    );
  }
}
