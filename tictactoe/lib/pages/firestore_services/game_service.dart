import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'dart:math';

final _logger = Logger('GameService');

String generateRoomId({int length = 6}) {
  const chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
  final rand = Random.secure();
  return List.generate(length, (_) => chars[rand.nextInt(chars.length)]).join();
}

class GameService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Create Game Room
  Future<String> createGame(String hostId) async {
    try {
      final roomId = generateRoomId();
      final docRef = _firestore
          .collection('games')
          .doc(roomId); // Auto-generates ID

      await docRef.set({
        'roomId': roomId,
        'playerX': hostId,
        'playerO': null,
        'board': List.generate(9, (_) => ''),
        'currentTurn': 'X',
        'winner': '',
        'isDraw': false,
        'isGameOver': false,
        'createdAt': FieldValue.serverTimestamp(),
      });
      return roomId;
    } catch (e) {
      _logger.severe('Error Creating Game: $e');
      rethrow;
    }
  }

  // Join existing game
  Future<void> joinGame(String roomId, String guestId) async {
    try {
      final docRef = _firestore.collection('games').doc(roomId);
      final doc = await docRef.get();

      if (!doc.exists) {
        throw Exception('Room does not Exist');
      }

      final data = doc.data();
      if (data == null || data['playerO'] != null) {
        throw Exception('Room is Full');
      }

      await docRef.update({
        'playerO': guestId,
        'joinedAt': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      debugPrint('Error Joining Game: $e');
      rethrow;
    }
  }

  // Listen to game state changes real time and stream
  Stream<DocumentSnapshot<Map<String, dynamic>>> streamGameRoom(String roomId) {
    return _firestore.collection('games').doc(roomId).snapshots();
  }

  // Make a move and check for winner/draw
  Future<void> makeMove(String roomId, int index) async {
    final docRef = _firestore.collection('games').doc(roomId);
    final doc = await docRef.get();

    if (!doc.exists) return;

    final data = doc.data()!;
    final board = List<String>.from(data['board']);
    final currentTurn = data['currentTurn'];
    final isGameOver = data['isGameOver'] ?? false;

    //Prevent move if already taken or game over
    if (board[index] != '' || isGameOver) return;

    board[index] = currentTurn;

    final winner = checkWinner(board);
    final isDraw = !board.contains('') && winner == '';

    await docRef.update({
      'board': board,
      'currentTurn': currentTurn == 'X' ? 'O' : 'X',
      'winner': winner,
      'isDraw': isDraw,
      'isGameOver': winner != '' || isDraw,
    });
  }

  // Reset Game Board
  Future<void> resetGame(String roomId) async {
    await _firestore.collection('games').doc(roomId).update({
      'board': List.generate(9, (_) => ''),
      'currentTurn': 'X',
      'winner': '',
      'isDraw': false,
      'isGameOver': false,
    });
  }

  // Check Winner
  String checkWinner(List<String> board) {
    const List<List<int>> winPatterns = [
      [0, 1, 2], [3, 4, 5], [6, 7, 8], // Rows
      [0, 3, 6], [1, 4, 7], [2, 5, 8], // Columns
      [0, 4, 8], [2, 4, 6], // Diagonals
    ];

    for (var pattern in winPatterns) {
      final a = pattern[0], b = pattern[1], c = pattern[2];
      if (board[a] != '' && board[a] == board[b] && board[b] == board[c]) {
        return board[a];
      }
    }
    return '';
  }
}
