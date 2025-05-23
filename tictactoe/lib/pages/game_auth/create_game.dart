import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tictactoe/colors/color.dart';
import 'package:tictactoe/pages/tools/app_loading.dart';
import 'package:tictactoe/pages/firestore_services/game_service.dart';

class CreateGame extends StatefulWidget {
  const CreateGame({super.key});

  @override
  State<CreateGame> createState() => _CreateGameState();
}

class _CreateGameState extends State<CreateGame> {
  String? roomId;
  bool isLoading = false;
  StreamSubscription<DocumentSnapshot>? gameSubscription;

  Future<void> _createGame() async {
    setState(() => isLoading = true);
    try {
      final hostId = FirebaseAuth.instance.currentUser!.uid;

      final generatedRoomId = await GameService().createGame(hostId);
      setState(() => roomId = generatedRoomId);

      _startGuestListener(generatedRoomId);
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Failed to create game: $e')));
    } finally {
      setState(() => isLoading = false);
    }
  }

  void _startGuestListener(String roomId) {
    final docRef = FirebaseFirestore.instance.collection('games').doc(roomId);
    gameSubscription = docRef.snapshots().listen((snapshot) {
      if (snapshot.exists) {
        final data = snapshot.data();
        if (data != null && data['guestId'] != null) {
          // Guest has joined, navigate to game page
          Navigator.pushReplacementNamed(
            context,
            '/multiplayer',
            arguments: roomId,
          );
        }
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _createGame(); // Create game on page load
  }

  @override
  void dispose() {
    gameSubscription?.cancel(); // Cancel the listener when leaving the page
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Appcolor.primaryColor,

      body: Center(
        child:
            isLoading
                ? const AppLoadingPage()
                : roomId == null
                ? Text(
                  'Failed To Create Game.',
                  style: GoogleFonts.coiny(
                    textStyle: TextStyle(color: Colors.white, fontSize: 40),
                  ),
                )
                : Container(
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
                          'Create Game',
                          style: GoogleFonts.coiny(
                            textStyle: TextStyle(
                              color: Colors.white,
                              fontSize: 35,
                            ),
                          ),
                        ),
                        SizedBox(height: 30),

                        Text(
                          'Share This RoomID To Your Friend',
                          style: GoogleFonts.coiny(
                            textStyle: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                            ),
                          ),
                        ),
                        SizedBox(height: 30),

                        SelectableText(
                          roomId!,
                          style: GoogleFonts.coiny(
                            textStyle: TextStyle(
                              color: Colors.white,
                              fontSize: 25,
                            ),
                          ),
                        ),
                        SizedBox(height: 30),

                        Text(
                          'Waiting For Player to Join...',
                          style: GoogleFonts.coiny(
                            textStyle: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
      ),
    );
  }
}
