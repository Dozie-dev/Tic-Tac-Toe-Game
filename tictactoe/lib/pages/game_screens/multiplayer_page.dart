import 'package:flutter/material.dart';
import 'package:tictactoe/colors/color.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tictactoe/pages/user_auth/profile.dart';

class MultiplayerPage extends StatefulWidget {
  const MultiplayerPage({super.key});

  @override
  State<MultiplayerPage> createState() => _MultiplayerPageState();
}

class _MultiplayerPageState extends State<MultiplayerPage> {
  // Custom Font
  static var customfontwhite = GoogleFonts.coiny(
    textStyle: TextStyle(color: Colors.white, fontSize: 35, letterSpacing: 3),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Appcolor.accentMulti,
      body: SafeArea(
        child: Column(
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
            Center(child: Text('Coming Soon', style: customfontwhite)),
          ],
        ),
      ),
    );
  }
}
