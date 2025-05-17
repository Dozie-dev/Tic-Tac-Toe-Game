import 'package:flutter/material.dart';
import 'package:tictactoe/colors/color.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tictactoe/pages/user_auth/profile_page.dart';

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
      backgroundColor: Appcolor.primaryMulti,
      body: Stack(
        children: [
          Positioned(
            top: 30,
            left: 30,
            child: IconButton.filled(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProfilePage()),
                );
              },
              icon: Icon(Icons.person_2),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(25.0),
            child: Column(
              children: [
                Expanded(
                  flex: 1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text('Player X', style: customfontwhite),
                          Text('0', style: customfontwhite),
                        ],
                      ),
                      SizedBox(width: 30),

                      Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text('Player O', style: customfontwhite),
                          Text('0', style: customfontwhite),
                        ],
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                    ),
                    itemCount: 9,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {},
                        child: Container(
                          decoration: BoxDecoration(
                            color: Appcolor.secondaryMulti,

                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(
                              width: 5,
                              color: Appcolor.primaryMulti,
                            ),
                          ),
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 10.0),
                              child: Text(
                                'X',
                                style: GoogleFonts.coiny(
                                  textStyle: TextStyle(
                                    color: Appcolor.primaryColor,
                                    fontSize: 65,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),

                Expanded(
                  flex: 2,
                  child: Center(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Text('Player X Wins', style: customfontwhite),

                          SizedBox(height: 20),

                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              padding: EdgeInsets.symmetric(
                                horizontal: 32,
                                vertical: 16,
                              ),
                            ),
                            onPressed: () {},
                            child: Text(
                              'Play Again!',
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          SizedBox(height: 30),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                iconSize: 50,
                                color: Colors.white,
                                onPressed: () {},
                                icon: Icon(Icons.restart_alt_rounded),
                              ),
                              IconButton(
                                iconSize: 50,
                                color: Colors.white,
                                onPressed: () {},
                                icon: Icon(
                                  Icons.volume_up_rounded,
                                  // : Icons.volume_off_rounded,
                                ),
                              ),
                            ],
                          ),
                          // Slider(
                          //   value: volume,
                          //   onChanged: changevolume,
                          //   min: 0.0,
                          //   max: 1.0,

                          //   activeColor: Colors.white,
                          //   inactiveColor: Colors.grey,
                          // ),
                        ],
                      ),
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
