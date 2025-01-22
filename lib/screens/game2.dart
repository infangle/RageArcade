import 'dart:async';
import 'package:flutter/material.dart';
import '../widgets/attack_icon_list.dart';
import '../widgets/boss_dialogue.dart';
import '../models/attacks.dart';

class Game2 extends StatefulWidget {
  final int currentScore;
  final int highestScore;
  final bool isMusicOn;
  final int bossHealth;

  const Game2({
    super.key,
    required this.currentScore,
    required this.highestScore,
    required this.isMusicOn,
    required this.bossHealth,
  });

  @override
  _Game2State createState() => _Game2State();
}

class _Game2State extends State<Game2> {
  String? _bossDialogue;
  late int currentScore;
  late int highestScore;
  late bool isMusicOn;
  late int _bossHealth;
  Timer? _healthRegenTimer;
  late List<Attack> level2Attacks;

  @override
  void initState() {
    super.initState();
    currentScore = widget.currentScore;
    highestScore = widget.highestScore;
    isMusicOn = widget.isMusicOn;
    _bossHealth = widget.bossHealth;

    // Filter attacks for Level 2
    level2Attacks = attacks.where((attack) => attack.level == 2).toList();

    _startHealthRegenTimer();
  }

  @override
  void dispose() {
    _healthRegenTimer?.cancel();
    super.dispose();
  }

  void _startHealthRegenTimer() {
    _healthRegenTimer?.cancel();
    _healthRegenTimer = Timer.periodic(const Duration(seconds: 10), (timer) {
      setState(() {
        if (_bossHealth < 100) {
          _bossHealth += 10;
          if (_bossHealth > 100) _bossHealth = 100;
        }
      });
    });
  }

  void _performAttack(Attack attack) {
    int damageValue = int.parse(attack.damage.split('/')[0]);

    setState(() {
      _bossDialogue = attack.dialogue2; // Dialogue specific to Level 2
      currentScore += damageValue;
      if (currentScore > highestScore) {
        highestScore = currentScore;
      }

      _bossHealth -= damageValue;
      if (_bossHealth <= 0) {
        _bossHealth = 0;
        _showWinnerPopup(); // Show the winner pop-up
      }
    });

    _startHealthRegenTimer();

    Future.delayed(const Duration(seconds: 5), () {
      setState(() {
        _bossDialogue = null;
      });
    });
  }

  void _showWinnerPopup() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: const Text(
            "Congratulations!",
            textAlign: TextAlign.center,
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "You defeated the boss!\nYour Score: $currentScore",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // Navigate to the home screen
                  IconButton(
                    icon: const Icon(Icons.home, size: 32),
                    onPressed: () {
                      Navigator.of(context).pushNamedAndRemoveUntil(
                        '/', // Main home route
                        (route) => false,
                      );
                    },
                  ),
                  // Restart the game
                  IconButton(
                    icon: const Icon(Icons.restart_alt, size: 32),
                    onPressed: () {
                      Navigator.of(context).pushNamedAndRemoveUntil(
                        '/game', // Game route
                        (route) => false,
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Level 2"),
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              // Add your settings logic here
              print("Settings clicked");
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  "Score: $currentScore",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                Text(
                  "High Score: $highestScore",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                IconButton(
                  icon: Icon(
                    isMusicOn ? Icons.volume_up : Icons.volume_off,
                  ),
                  onPressed: () {
                    setState(() {
                      isMusicOn = !isMusicOn;
                    });
                  },
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
                    'lib/assets/images/boss2.jpg',
                  ),
                ),
                if (_bossDialogue != null)
                  Positioned(
                    top: 16.0,
                    right: 16.0,
                    child: BossDialogue(
                      dialogue: _bossDialogue!,
                    ),
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
              attacks: level2Attacks,
            ),
          ),
        ],
      ),
    );
  }
}
