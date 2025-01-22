import 'dart:async';
import 'package:flutter/material.dart';
import 'game2.dart'; // Next level screen

import '../widgets/attack_icon_list.dart'; // Attack options widget
import '../widgets/boss_dialogue.dart'; // Dialogue widget
import '../models/attacks.dart'; // Attack model
import '../widgets/audio.dart'; // Import the Audio widget

class MyGame extends StatefulWidget {
  const MyGame({super.key});

  @override
  _MyGameState createState() => _MyGameState();
}

class _MyGameState extends State<MyGame> {
  String? _bossDialogue;
  int currentScore = 0;
  int highestScore = 0;
  bool isMusicOn = true;
  int _bossHealth = 99; // Initialize to 99 to avoid game over at start
  Timer? _healthRegenTimer;
  late List<Attack> levelAttacks;

  final String musicUrl =
      'https://example.com/game-music.mp3'; // Replace with your music URL

  @override
  void initState() {
    super.initState();
    levelAttacks = attacks.where((attack) => attack.level == 1).toList();
    _startHealthRegenTimer();
  }

  @override
  void dispose() {
    _healthRegenTimer?.cancel();
    super.dispose();
  }

  void _startHealthRegenTimer() {
    _healthRegenTimer = Timer.periodic(const Duration(seconds: 10), (timer) {
      if (_bossHealth < 100) {
        setState(() {
          _bossHealth += 10;
          if (_bossHealth > 100) _bossHealth = 100;
        });

        if (_bossHealth == 100) {
          _showGameOverDialog();
        }
      }
    });
  }

  void _performAttack(Attack attack) {
    int damage = int.parse(attack.damage.split('/')[0]);

    setState(() {
      _bossDialogue = attack.dialogue1;
      currentScore += damage;
      highestScore = currentScore > highestScore ? currentScore : highestScore;

      _bossHealth -= damage;
      if (_bossHealth < 0) _bossHealth = 0;
    });

    if (_bossHealth <= 50) {
      setState(() {
        levelAttacks = attacks.where((attack) => attack.level == 2).toList();
      });

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => Game2(
            currentScore: currentScore,
            highestScore: highestScore,
            isMusicOn: isMusicOn,
          ),
        ),
      );
    }

    _startHealthRegenTimer();

    Future.delayed(const Duration(seconds: 5), () {
      setState(() {
        _bossDialogue = null;
      });
    });
  }

  void _toggleMusic(bool isMusicEnabled) {
    setState(() {
      isMusicOn = isMusicEnabled;
    });
  }

  void _showGameOverDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Text("Game Over"),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text("The boss is back with all mighty powers."),
              const SizedBox(height: 8.0),
              Text("Score: $currentScore"),
              const SizedBox(height: 4.0),
              Text("High Score: $highestScore"),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              setState(() {
                _bossHealth = 99; // Restart game
                currentScore = 0;
                levelAttacks =
                    attacks.where((attack) => attack.level == 1).toList();
              });
            },
            child: const Text("Restart"),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Exit"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Level 1"),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Score: $currentScore",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                Text(
                  "High Score: $highestScore",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                Audio(
                  isMusicOn: isMusicOn,
                  musicUrl: musicUrl,
                  onToggle: _toggleMusic,
                ),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Stack(
              children: [
                Positioned.fill(
                  child: Image.asset(
                    'lib/assets/images/boss.jpg',
                    fit: BoxFit.cover,
                  ),
                ),
                if (_bossDialogue != null)
                  Positioned(
                    top: 16.0,
                    right: 16.0,
                    child: BossDialogue(dialogue: _bossDialogue!),
                  ),
              ],
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.5,
                  decoration: BoxDecoration(
                    color: Colors.red.shade200,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: LinearProgressIndicator(
                      minHeight: 16.0,
                      value: _bossHealth / 100,
                      backgroundColor: Colors.transparent,
                      valueColor:
                          const AlwaysStoppedAnimation<Color>(Colors.green),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text(
                    "${_bossHealth} HP",
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: AttackIconList(
              onAttack: _performAttack,
              attacks: levelAttacks,
            ),
          ),
        ],
      ),
    );
  }
}
