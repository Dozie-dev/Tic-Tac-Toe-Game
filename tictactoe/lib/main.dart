import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:tictactoe/pages/firebase_auth/auth_gate.dart';
import 'package:tictactoe/pages/first_screens/welcome_page.dart';
import 'package:tictactoe/pages/game_auth/create_game.dart';
import 'package:tictactoe/pages/game_screens/multiplayer_page.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/', // Start here
      routes: {
        '/': (context) => const AuthGate(),
        '/welcome': (context) => const WelcomePage(),
        '/creategame': (context) => const CreateGame(),
        '/multiplayer': (context) => const MultiplayerPage(),
      },
    );
  }
}
