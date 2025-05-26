import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tictactoe/colors/color.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tictactoe/pages/firestore_services/game_service.dart';
import 'package:tictactoe/pages/tools/app_loading.dart';
import 'package:tictactoe/pages/user_auth/profile_page.dart';

class MultiplayerPage extends StatefulWidget {
  final String roomId;

  const MultiplayerPage({super.key, required this.roomId});

  @override
  State<MultiplayerPage> createState() => _MultiplayerPageState();
}

class _MultiplayerPageState extends State<MultiplayerPage> {
  // Custom Font
  static var customfontwhite = GoogleFonts.coiny(
    textStyle: TextStyle(color: Colors.white, fontSize: 35, letterSpacing: 3),
  );
  late Stream<DocumentSnapshot> _gameStream;
  final GameService _gameService = GameService();
  final String _currentUserId = FirebaseAuth.instance.currentUser!.uid;

  String hostUsername = '';
  String guestUsername = '';

  @override
  void initState() {
    super.initState();
    _gameStream = _gameService.streamGameRoom(widget.roomId);
  }

  Future<void> _loadUsernames(String hostId, String guestId) async {
    final hostDoc =
        await FirebaseFirestore.instance.collection('games').doc(hostId).get();
    final guestDoc =
        await FirebaseFirestore.instance.collection('games').doc(guestId).get();

    setState(() {
      hostUsername = hostDoc.data()?['username'] ?? 'Player X';
      guestUsername = guestDoc.data()?['username'] ?? 'Player O';
    });
  }

  void _makeMove(
    int index,
    List<String> board,
    String currentTurn,
    String hostId,
    String guestId,
    bool isGameOver,
  ) async {
    // Only allow move if it's this player's turn and the game isn't over
    if (isGameOver || board[index] != '') return;

    final isPlayerX = _currentUserId == hostId;
    final isMyTurn =
        (currentTurn == 'X' && isPlayerX) || (currentTurn == 'O' && !isPlayerX);

    if (!isMyTurn) return;

    try {
      await _gameService.makeMove(widget.roomId, index);
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Move Failed: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Appcolor.primaryMulti,
      body: StreamBuilder<DocumentSnapshot>(
        stream: _gameStream,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const AppLoadingPage();
          }

          final data = snapshot.data!.data() as Map<String, dynamic>;
          final board = List<String>.from(data['board']);
          final currentTurn = data['currentTurn'];
          final winner = data['winner'] ?? '';
          final isDraw = data['isDraw'] ?? false;
          final isGameOver = data['isGameOver'] ?? false;
          final hostId = data['hostId'];
          final guestId = data['guestId'];

          //fetch Usernames when room loads
          if (hostUsername == '' || guestUsername == '') {
            _loadUsernames(hostId, guestId);
          }

          String statusText;
          if (isGameOver) {
            if (isDraw) {
              statusText = 'Nobody Wins!';
            } else if ((winner == 'X' && _currentUserId == hostId) ||
                (winner == 'O' && _currentUserId == guestId)) {
              statusText = 'You Win!';
            } else {
              statusText = 'You Lose!';
            }
          } else {
            final isMyTurn =
                (currentTurn == 'X' && _currentUserId == hostId) ||
                (currentTurn == 'O' && _currentUserId == guestId);
            statusText = isMyTurn ? 'Your Turn' : 'Opponent\'s Turn';
          }

          return Stack(
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
          );
        },
      ),
    );
  }
}
