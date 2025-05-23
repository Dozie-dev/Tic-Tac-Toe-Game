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

  // Game Logic
  Future<String> createGame(String hostId) async {
    try {
      final roomId = generateRoomId();
      final docRef = _firestore.collection('games').doc(roomId); // Auto-generates ID
      

      await docRef.set({
        'roomId': roomId,
        'hostId': hostId,
        'guestId': null,
        'board': List.generate(9, (_) => ''),
        'turn': hostId,
        'winner': null,
        'isDraw': false,
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
      if (data == null || data['guestId'] != null) {
        throw Exception('Room is Full');
      }

      await docRef.update({
        'guestId': guestId,
        'guestJoinedAt': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      debugPrint('Error Joining Game: $e');
      rethrow;
    }
  }

  // Listen to game state changes real time
  Stream<DocumentSnapshot> listenToGame(String roomId) {
    return _firestore.collection('games').doc(roomId).snapshots();
  }

  // Update board after move
  Future<void> updateBoard(
    String roomId,
    List<String> board,
    String currentTurn,
  ) async {
    await _firestore.collection('games').doc(roomId).update({
      'board': board,
      'currentTurn': currentTurn,
    });
  }

  // Mark game as over
  Future<void> endGame(String roomId, String winner) async {
    await _firestore.collection('games').doc(roomId).update({
      'isGameOver': true,
      'winner': winner,
    });
  }
}
