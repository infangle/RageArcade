import 'package:flutter/material.dart';
import 'widgets/attack_icon_list.dart';
import 'widgets/boss_dialogue.dart';
import 'models/attacks.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rage Arcade',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyGame(),
    );
  }
}

class MyGame extends StatefulWidget {
  const MyGame({super.key});

  @override
  _MyGameState createState() => _MyGameState();
}

class _MyGameState extends State<MyGame> {
  String? _bossDialogue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Rage Arcade"),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          // Boss image with dialogue stacked on top
          Expanded(
            flex: 2,
            child: Stack(
              children: [
                // Boss Image
                Positioned.fill(
                  child: Image.asset(
                    'lib/assets/images/boss.jpg',
                    fit: BoxFit.cover,
                  ),
                ),

                // Dialogue Overlay
                if (_bossDialogue != null)
                  BossDialogue(
                      dialogue:
                          _bossDialogue!), // Positioned at top-right corner
              ],
            ),
          ),

          // Attack Icons List
          Expanded(
            flex: 1,
            child: AttackIconList(
              onAttack: _performAttack,
              attacks: attacks, // Imported attack details
            ),
          ),
        ],
      ),
    );
  }

  // Function to handle attack logic
  void _performAttack(String dialogue) {
    setState(() {
      _bossDialogue = dialogue;
    });

    Future.delayed(const Duration(seconds: 5), () {
      setState(() {
        _bossDialogue = null;
      });
    });
  }
}
