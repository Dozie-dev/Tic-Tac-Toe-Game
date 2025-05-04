import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tictactoe/colors/color.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  static var customFontWhite = GoogleFonts.coiny(
    textStyle: TextStyle(color: Colors.white, fontSize: 35, letterSpacing: 3),
  );
  static var customFontBlack = GoogleFonts.coiny(
    textStyle: TextStyle(color: Colors.black, fontSize: 20, letterSpacing: 3),
  );
  bool oturn = true;
  List<String> displayXO = ['', '', '', '', '', '', '', '', ''];
  String results = '';

  List<int> winningindexes = [];

  int oScore = 0;
  int xScore = 0;
  int filledboxes = 0;
  bool winnerfound = false;

  String playerX = '';
  String playerO = '';
  bool playername = false;

  final TextEditingController playerXController = TextEditingController();
  final TextEditingController playerOController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      playerNameDialog();
    });
  }

  void playerNameDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder:
          (_) => AlertDialog(
            backgroundColor: Appcolor.primaryColor,
            title: Text('Enter Player Names', style: customFontWhite),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: playerXController,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    labelText: 'Player X',
                    labelStyle: TextStyle(color: Colors.white),
                  ),
                ),
                TextField(
                  controller: playerOController,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    labelText: 'Player O',
                    labelStyle: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
            actions: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
                onPressed: () {
                  if (playerXController.text.isNotEmpty &&
                      playerOController.text.isNotEmpty) {
                    setState(() {
                      playerX = playerXController.text;
                      playerO = playerOController.text;
                      playername = true;
                    });
                    Navigator.of(context).pop();
                  }
                },
                child: Text('Start Game', style: customFontBlack),
              ),
            ],
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Appcolor.primaryColor,
      body: Padding(
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
                      Text(
                        playerX.isEmpty ? 'Player X' : playerX,
                        style: customFontWhite,
                      ),
                      Text(xScore.toString(), style: customFontWhite),
                    ],
                  ),
                  SizedBox(width: 25),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        playerO.isEmpty ? 'Player O' : playerO,
                        style: customFontWhite,
                      ),
                      Text(oScore.toString(), style: customFontWhite),
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
                    onTap: () {
                      if (playername)
                        // ignore: curly_braces_in_flow_control_structures
                        tapped(index);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color:
                            winningindexes.contains(index)
                                ? Colors
                                    .greenAccent // Highlight winning cells
                                : Appcolor.secondaryColor,

                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(
                          width: 5,
                          color: Appcolor.primaryColor,
                        ),
                      ),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 10.0),
                          child: Text(
                            displayXO[index],
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
                child: Column(
                  children: [
                    Text(results, style: customFontWhite),
                    SizedBox(height: 20),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        padding: EdgeInsets.symmetric(
                          horizontal: 32,
                          vertical: 16,
                        ),
                      ),
                      onPressed: () {
                        clearboard();
                      },
                      child: Text(
                        'Play Again!',
                        style: TextStyle(fontSize: 20, color: Colors.black),
                      ),
                    ),
                    SizedBox(height: 30),
                    IconButton(
                      iconSize: 50,
                      color: Colors.white,
                      onPressed: () {
                        resetscore();
                        clearboard();
                      },
                      icon: Icon(Icons.restart_alt_rounded),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void tapped(int index) {
    if (displayXO[index] != '' || winnerfound) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Invalid move")));
      return;
    }

    setState(() {
      // ignore: unrelated_type_equality_checks
      if (oturn && displayXO[index] == '') {
        displayXO[index] = 'O';
        filledboxes++;
      } else if (!oturn && displayXO[index] == '') {
        displayXO[index] = 'X';
        filledboxes++;
      }

      oturn = !oturn;
      checkwinner();
    });
  }

  void checkwinner() {
    winningindexes.clear();
    //1st Row
    if (displayXO[0] == displayXO[1] &&
        displayXO[0] == displayXO[2] &&
        displayXO[0] != '') {
      setState(() {
        winningindexes = [0, 1, 2];
        results = 'Player ${displayXO[0]} Wins!';
        updateScore(displayXO[0]);
      });
    }
    //2nd Row
    if (displayXO[3] == displayXO[4] &&
        displayXO[3] == displayXO[5] &&
        displayXO[3] != '') {
      setState(() {
        winningindexes = [3, 4, 5];
        results = 'Player ${displayXO[3]} Wins!';
        updateScore(displayXO[3]);
      });
    }
    //3rd Row
    if (displayXO[6] == displayXO[7] &&
        displayXO[6] == displayXO[8] &&
        displayXO[6] != '') {
      setState(() {
        winningindexes = [6, 7, 8];
        results = 'Player${displayXO[6]}Wins!';
        updateScore(displayXO[6]);
      });
    }
    //1st Column
    if (displayXO[0] == displayXO[3] &&
        displayXO[0] == displayXO[6] &&
        displayXO[0] != '') {
      setState(() {
        winningindexes = [0, 3, 6];
        results = 'Player ${displayXO[0]} Wins!';
        updateScore(displayXO[0]);
      });
    }
    //2nd Column
    if (displayXO[1] == displayXO[4] &&
        displayXO[1] == displayXO[7] &&
        displayXO[1] != '') {
      setState(() {
        winningindexes = [1, 4, 7];
        results = 'Player ${displayXO[1]} Wins!';
        updateScore(displayXO[1]);
      });
    }
    //3rd Column
    if (displayXO[2] == displayXO[5] &&
        displayXO[2] == displayXO[8] &&
        displayXO[2] != '') {
      setState(() {
        winningindexes = [2, 5, 8];
        results = 'Player ${displayXO[2]} Wins!';
        updateScore(displayXO[2]);
      });
    }
    //1st Diagonal
    if (displayXO[0] == displayXO[4] &&
        displayXO[0] == displayXO[8] &&
        displayXO[0] != '') {
      setState(() {
        winningindexes = [0, 4, 8];
        results = 'Player ${displayXO[0]}Wins!';
        updateScore(displayXO[0]);
      });
    }
    //2nd Diagonal
    if (displayXO[6] == displayXO[4] &&
        displayXO[6] == displayXO[2] &&
        displayXO[6] != '') {
      setState(() {
        winningindexes = [6, 4, 2];
        results = 'Player${displayXO[6]}Wins!';
        updateScore(displayXO[6]);
      });
    }
    if (!winnerfound && filledboxes == 9) {
      setState(() {
        results = 'Nobody Wins!';
      });
    }
  }

  void updateScore(String winner) {
    if (winner == 'O') {
      oScore++;
    } else if (winner == 'X') {
      xScore++;
    }
    winnerfound = true;
  }

  void clearboard() {
    setState(() {
      for (int i = 0; i < 9; i++) {
        displayXO[i] = '';
      }
      results = '';
      filledboxes = 0;
      winnerfound = false;
      winningindexes.clear();
    });
  }

  void resetscore() {
    setState(() {
      xScore = 0;
      oScore = 0;
      winningindexes.clear();
    });
  }
}
