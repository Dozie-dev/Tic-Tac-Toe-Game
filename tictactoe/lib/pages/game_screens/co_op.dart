import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tictactoe/colors/color.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:tictactoe/pages/first_screens/landing_page.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  // The custom font through out the app
  static var customFontWhite = GoogleFonts.coiny(
    textStyle: TextStyle(color: Colors.white, fontSize: 35, letterSpacing: 3),
  );
  // static var customFontBlack = GoogleFonts.coiny(
  //   textStyle: TextStyle(color: Colors.black, fontSize: 20, letterSpacing: 3),
  //);

  // Function to call the music
  void playMusic() async {
    await audioplayer.setReleaseMode(ReleaseMode.loop); // Loop the music
    await audioplayer.play(AssetSource('audio/backgroundsound.flac'));
  }

  @override
  void dispose() {
    audioplayer.dispose();
    super.dispose();
  }

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

  bool isPlaying = true;

  final TextEditingController playerXController = TextEditingController();
  final TextEditingController playerOController = TextEditingController();

  late AudioPlayer audioplayer;
  // Volume variable
  double volume = 1.0;

  @override
  void initState() {
    super.initState();
    audioplayer = AudioPlayer();
    playMusic();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      playerNameDialog();
    });
  }

  void toggleMusic() {
    if (isPlaying) {
      audioplayer.pause();
    } else {
      audioplayer.resume();
    }
    setState(() {
      isPlaying = !isPlaying;
    });
  }

  //Method to update volume
  void changevolume(double newvolume) {
    setState(() {
      volume = newvolume;
    });
    audioplayer.setVolume(volume);
  }

  void playerNameDialog() {
    showDialog(
      context: context,
      barrierDismissible: false, // Prevent dismissal without submitting
      builder: (BuildContext context) {
        return PopScope(
          canPop: false, // Disables back button
          child: Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            backgroundColor: Appcolor.primaryColor,

            child: GestureDetector(
              onTap: () => FocusScope.of(context).unfocus(), // dismiss keyboard
              child: SingleChildScrollView(
                padding: EdgeInsets.only(
                  left: 20,
                  right: 20,
                  top: 20,
                  bottom: MediaQuery.of(context).viewInsets.bottom + 20,
                ),
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    return Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "Enter Player Names",
                            style: GoogleFonts.coiny(
                              textStyle: TextStyle(
                                fontSize: 24,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          TextField(
                            controller: playerXController,
                            decoration: InputDecoration(
                              labelText: 'Player X',
                              labelStyle: TextStyle(color: Colors.white70),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            style: TextStyle(color: Colors.white),
                          ),
                          const SizedBox(height: 15),
                          TextField(
                            controller: playerOController,
                            decoration: InputDecoration(
                              labelText: 'Player O',
                              labelStyle: TextStyle(color: Colors.white70),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            style: TextStyle(color: Colors.white),
                          ),
                          const SizedBox(height: 25),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              foregroundColor: Appcolor.primaryColor,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 30,
                                vertical: 12,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            onPressed: () {
                              final xName = playerXController.text.trim();
                              final oName = playerOController.text.trim();
                              if (xName.isNotEmpty && oName.isNotEmpty) {
                                Navigator.of(context).pop();
                                setState(() {
                                  playerX = playerXController.text;
                                  playerO = playerOController.text;
                                  playername = true;
                                });
                              }
                            },
                            child: Text(
                              "Start Game",
                              style: GoogleFonts.coiny(fontSize: 20),
                            ),
                          ),
                          SizedBox(height: 10),
                          SizedBox(
                            width: 160,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                foregroundColor: Appcolor.primaryColor,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 30,
                                  vertical: 12,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => FirstPage(),
                                  ),
                                );
                                audioplayer.stop();
                              },
                              child: Text(
                                "Exit",
                                style: GoogleFonts.coiny(fontSize: 20),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  // void playerNameDialog() {
  //   showDialog(
  //     context: context,
  //     barrierDismissible: false,
  //     builder:
  //         (_) => AlertDialog(
  //           backgroundColor: Appcolor.primaryColor,
  //           title: Text('Enter Player Names', style: customFontWhite),
  //           content: Column(
  //             mainAxisSize: MainAxisSize.min,
  //             children: [
  //               TextField(
  //                 controller: playerXController,
  //                 style: TextStyle(color: Colors.white),
  //                 decoration: InputDecoration(
  //                   labelText: 'Player X',
  //                   labelStyle: TextStyle(color: Colors.white),
  //                 ),
  //               ),
  //               TextField(
  //                 controller: playerOController,
  //                 style: TextStyle(color: Colors.white),
  //                 decoration: InputDecoration(
  //                   labelText: 'Player O',
  //                   labelStyle: TextStyle(color: Colors.white),
  //                 ),
  //               ),
  //             ],
  //           ),
  //           actions: [
  //             ElevatedButton(
  //               style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
  //               onPressed: () {
  //                 if (playerXController.text.isNotEmpty &&
  //                     playerOController.text.isNotEmpty) {
  //                   setState(() {
  //                     playerX = playerXController.text;
  //                     playerO = playerOController.text;
  //                     playername = true;
  //                   });
  //                   Navigator.of(context).pop();
  //                 }
  //               },
  //               child: Text('Start Game', style: customFontBlack),
  //             ),
  //           ],
  //         ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
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
                  SizedBox(
                    width: 150,
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Image.asset('assets/icons/close.png', width: 40),
                          Text(
                            playerX.isEmpty ? 'Player X' : playerX,
                            style: customFontWhite,
                          ),
                          Text(xScore.toString(), style: customFontWhite),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: 25),
                  SizedBox(
                    width: 150,
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Image.asset('assets/icons/open.png', width: 40),
                          Text(
                            playerO.isEmpty ? 'Player O' : playerO,
                            style: customFontWhite,
                          ),
                          Text(oScore.toString(), style: customFontWhite),
                        ],
                      ),
                    ),
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
                child: SingleChildScrollView(
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            iconSize: 50,
                            color: Colors.white,
                            onPressed: () {
                              resetscore();
                              clearboard();
                            },
                            icon: Icon(Icons.restart_alt_rounded),
                          ),
                          IconButton(
                            iconSize: 50,
                            color: Colors.white,
                            onPressed: toggleMusic,
                            icon: Icon(
                              isPlaying
                                  ? Icons.volume_up_rounded
                                  : Icons.volume_off_rounded,
                            ),
                          ),
                        ],
                      ),
                      Slider(
                        value: volume,
                        onChanged: changevolume,
                        min: 0.0,
                        max: 1.0,

                        activeColor: Colors.white,
                        inactiveColor: Colors.grey,
                      ),
                    ],
                  ),
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
        displayXO[index] = 'X';
        filledboxes++;
      } else if (!oturn && displayXO[index] == '') {
        displayXO[index] = 'O';
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
