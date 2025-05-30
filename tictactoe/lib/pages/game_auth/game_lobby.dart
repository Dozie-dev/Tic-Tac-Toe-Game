import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tictactoe/colors/color.dart';
import 'package:tictactoe/pages/game_auth/create_game.dart';
import 'package:tictactoe/pages/firestore_services/game_service.dart';

class GameLobby extends StatefulWidget {
  const GameLobby({super.key});

  @override
  State<GameLobby> createState() => _GameLobbyState();
}

class _GameLobbyState extends State<GameLobby> {
  @override
  Widget build(BuildContext context) {
    final TextEditingController roomIdController = TextEditingController();
    bool isLoading = false;

    Future<void> joinGame() async {
      final roomId = roomIdController.text;
      final guestId = FirebaseAuth.instance.currentUser?.uid;

      if (roomId.isEmpty || guestId == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Room ID or User not valid')),
        );
        return;
      }

      setState(() => isLoading = true);

      try {
        await GameService().joinGame(roomId, guestId);

        // Fetch hostId from Firestore document
        final gameDoc =
            await FirebaseFirestore.instance
                .collection('games')
                .doc(roomId)
                .get();

        if (!gameDoc.exists) {
          throw Exception('Game room not found');
        }

        final hostId = gameDoc.data()?['hostId'] as String?;

        if (hostId == null) {
          throw Exception('hostId not found');
        }

        Navigator.pushNamed(
          context,
          '/multiplayer',
          arguments: {'roomId': roomId, 'hostId': hostId},
        );
      } catch (e) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Failed to join game: $e')));
      } finally {
        setState(() => isLoading = false);
      }
    }

    return Scaffold(
      backgroundColor: Colors.white70,
      body: Stack(
        children: [
          Center(
            child: Container(
              height: 270,
              width: 350,
              decoration: BoxDecoration(
                color: Appcolor.primaryColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Multiplayer Lobby',
                      style: GoogleFonts.coiny(
                        textStyle: TextStyle(color: Colors.white, fontSize: 35),
                      ),
                    ),

                    SizedBox(height: 20),
                    SizedBox(
                      width: 250,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CreateGame(),
                            ),
                          );
                        },
                        child: Text(
                          'Create Game',
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    ),

                    SizedBox(height: 20),
                    SizedBox(
                      width: 250,
                      child: TextFormField(
                        controller: roomIdController,
                        decoration: InputDecoration(
                          hintText: 'Enter Room ID',
                          filled: true,
                          fillColor: Colors.white70,
                          contentPadding: EdgeInsets.symmetric(horizontal: 16),
                        ),
                      ),
                    ),

                    SizedBox(
                      width: 250,
                      child: ElevatedButton(
                        onPressed: isLoading ? null : joinGame,

                        child:
                            isLoading
                                ? const CircularProgressIndicator()
                                : const Text(
                                  'Join Game',
                                  style: TextStyle(fontSize: 20),
                                ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 35,
            left: 0,
            right: 0,
            child: Opacity(
              opacity: 0.5,
              child: Image.asset('assets/images/backpicture.png', width: 150),
            ),
          ),
        ],
      ),
    );
  }
}
