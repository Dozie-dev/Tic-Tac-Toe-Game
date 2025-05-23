import 'package:flutter/material.dart';
import 'package:tictactoe/colors/color.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tictactoe/pages/game_auth/game_lobby.dart';
import 'package:tictactoe/pages/game_screens/co_op.dart';
import 'package:tictactoe/pages/user_auth/profile_page.dart';

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
          Positioned(
            top: 50,
            left: 30,
            child: Row(
              children: [
                IconButton.filled(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ProfilePage()),
                    );
                  },
                  icon: Icon(Icons.person_2),
                ),
                SizedBox(width: 20),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Text(
                    'PROFILE',
                    style: GoogleFonts.coiny(
                      textStyle: TextStyle(color: Colors.white, fontSize: 25),
                    ),
                  ),
                ),
              ],
            ),
          ),

          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'CHOOSE GAME MODE',
                  style: GoogleFonts.coiny(
                    textStyle: TextStyle(color: Colors.white, fontSize: 35),
                  ),
                ),
                SizedBox(height: 20),
                Transform.rotate(
                  angle: 0.1,
                  child: Image.asset('assets/images/tictactoe.png', width: 300),
                ),
                SizedBox(height: 50),
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
                      MaterialPageRoute(builder: (context) => GameLobby()),
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
