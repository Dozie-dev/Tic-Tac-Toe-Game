import 'package:flutter/material.dart';
import 'package:tictactoe/colors/color.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tictactoe/pages/co_op.dart';
import 'package:tictactoe/pages/multiplayer_page.dart';

class FirstPage extends StatelessWidget {
  const FirstPage({super.key});

  @override
  Widget build(BuildContext context) {
    var customwhitefont = GoogleFonts.coiny(
      textStyle: TextStyle(
        color: Appcolor.primaryColor,
        fontSize: 25,
        letterSpacing: 3,
      ),
    );
    return Scaffold(
      backgroundColor: Appcolor.primaryColor,
      body: Stack(
        children: [
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Tic-Tac-Toe Game',
                  style: GoogleFonts.coiny(
                    textStyle: TextStyle(
                      color: Colors.white,
                      letterSpacing: 3,
                      fontSize: 35,
                    ),
                  ),
                ),
                SizedBox(height: 70),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () async {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LandingPage()),
                    );
                  },
                  child: Text('CO_OP', style: customwhitefont),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () async {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MultiplayerPage(),
                      ),
                    );
                  },
                  child: Text('MULTIPLAYER', style: customwhitefont),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 20,
            left: 0,
            right: 0,
            child: Text(
              textAlign: TextAlign.center,
              'DOZIE TECHNOLOGIES',
              style: GoogleFonts.coiny(
                textStyle: TextStyle(
                  color: Colors.white,
                  letterSpacing: 3,
                  fontSize: 10,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
