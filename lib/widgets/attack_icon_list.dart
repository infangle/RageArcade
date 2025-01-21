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
      padding: const EdgeInsets.symmetric(
          vertical: 16.0), // Add spacing above and below
      child: SingleChildScrollView(
        child: Row(
          mainAxisAlignment:
              MainAxisAlignment.spaceEvenly, // Space icons evenly
          children: attacks.map((attack) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(attack.icon),
                  iconSize: 36.0, // Set a consistent size for icons
                  onPressed: () => onAttack(attack),
                  tooltip: attack.name,
                ),
                Text(
                  attack.name,
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall, // Text below each icon
                  textAlign: TextAlign.center,
                ),
              ],
            );
          }).toList(),
        ),
      ),
    );
  }
}
