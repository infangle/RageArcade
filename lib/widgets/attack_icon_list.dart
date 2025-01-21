import 'package:flutter/material.dart';
import '../models/attacks.dart';

class AttackIconList extends StatelessWidget {
  final Function(Attack) onAttack;
  final List<Attack> attacks;

  const AttackIconList({
    Key? key,
    required this.onAttack,
    required this.attacks,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.symmetric(vertical: 16.0), // Spacing above and below
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal, // Allow horizontal scrolling
        child: Row(
          children: attacks.map((attack) {
            return Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: 12.0), // Add spacing between icons
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: Icon(attack.icon),
                    iconSize: 48.0, // Increase icon size for better visibility
                    color: Colors.blueAccent,
                    // Gray if not clicked, blue if clicked
                    onPressed: () {
                      onAttack(attack);
                    },
                    tooltip: attack.name,
                  ),
                  Text(
                    attack.name,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          fontSize: 12.0, // Consistent font size
                          fontWeight: FontWeight.bold, // Emphasize attack names
                        ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
