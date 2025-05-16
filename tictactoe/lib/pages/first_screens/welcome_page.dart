import 'package:flutter/material.dart';
import 'package:tictactoe/colors/color.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tictactoe/pages/user_auth/login_page.dart';
import 'package:tictactoe/pages/user_auth/register_page.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

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
                Transform.rotate(
                  angle: 0.1,
                  child: Image.asset('assets/images/tictactoe.png', width: 300),
                ),
                SizedBox(height: 50),
                SizedBox(
                  width: 250,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () async {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => RegisterPage()),
                      );
                    },
                    child: Text('REGISTER', style: customwhitefont),
                  ),
                ),
                SizedBox(height: 10),
                SizedBox(
                  width: 250,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () async {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LoginPage()),
                      );
                    },
                    child: Text('LOG IN', style: customwhitefont),
                  ),
                ),

                SizedBox(height: 50),

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
