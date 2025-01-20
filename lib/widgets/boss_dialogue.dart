import 'package:flutter/material.dart';

class BossDialogue extends StatelessWidget {
  final String dialogue;

  const BossDialogue({required this.dialogue, super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 80, // Positioned below the app bar
      right: 10, // Aligned to the right of the screen
      child: Material(
        color: Colors.transparent,
        child: Container(
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.7),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            dialogue,
            textAlign: TextAlign.left, // Align text to the left
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
