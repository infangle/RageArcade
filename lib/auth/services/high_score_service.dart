import 'package:cloud_firestore/cloud_firestore.dart';

class HighScoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Save high score
  Future<void> saveHighScore(
      String playerId, String username, int score) async {
    await _firestore.collection('highscores').doc(playerId).set({
      'username': username,
      'score': score,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  // Retrieve high scores
  Future<List<Map<String, dynamic>>> getHighScores() async {
    QuerySnapshot snapshot = await _firestore
        .collection('highscores')
        .orderBy('score', descending: true)
        .limit(10) // Get top 10 scores
        .get();

    return snapshot.docs
        .map((doc) => doc.data() as Map<String, dynamic>)
        .toList();
  }
}
