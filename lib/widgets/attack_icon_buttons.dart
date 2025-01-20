import 'package:flutter/material.dart';
import '../models/attacks.dart';

class AttackIconButton extends StatelessWidget {
  final Attack attack;
  final Function(String) onDoubleTap;

  const AttackIconButton({
    required this.attack,
    required this.onDoubleTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _showAttackInfo(context),
      onDoubleTap: () =>
          onDoubleTap('${attack.dialogue1}\n${attack.dialogue2}'),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          children: [
            Icon(attack.icon, size: 40),
            Text(attack.name, style: const TextStyle(fontSize: 12)),
          ],
        ),
      ),
    );
  }

  void _showAttackInfo(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(attack.name),
          content: Text('Damage: ${attack.damage}\nEffect: ${attack.effect}'),
          actions: [
            TextButton(
              child: const Text('Close'),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        );
      },
    );
  }
}
