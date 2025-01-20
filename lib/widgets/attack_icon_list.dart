import 'package:flutter/material.dart';
import '../models/attacks.dart';

class AttackIconList extends StatelessWidget {
  final Function(String) onAttack;
  final List<Attack> attacks;

  const AttackIconList({
    Key? key,
    required this.onAttack,
    required this.attacks,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 20, // Position it a bit below the center of the screen
      left: 20, // Adjust positioning
      right: 20, // Adjust positioning
      child: SingleChildScrollView(
        scrollDirection:
            Axis.horizontal, // Make the list horizontally scrollable
        child: Row(
          children: attacks.map((attack) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: IconButton(
                icon: Icon(attack.icon),
                onPressed: () =>
                    onAttack(attack.dialogue1), // Trigger attack dialogue
                iconSize: 50, // Adjust icon size as needed
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
