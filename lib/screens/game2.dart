import 'dart:async';
import 'package:flutter/material.dart';
import '../widgets/attack_icon_list.dart';
import '../widgets/boss_dialogue.dart';
import '../models/attacks.dart';

class Game2 extends StatefulWidget {
  final int currentScore;
  final int highestScore;
  final bool isMusicOn;

  const Game2({
    super.key,
    required this.currentScore,
    required this.highestScore,
    required this.isMusicOn,
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
    _bossHealth = 49; // Initial boss HP

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
    // Start or restart the health regeneration timer
    _healthRegenTimer?.cancel();
    _healthRegenTimer = Timer.periodic(const Duration(seconds: 10), (timer) {
      if (_bossHealth < 100) {
        setState(() {
          _bossHealth = (_bossHealth + 10).clamp(0, 100);
        });
      }
    });
  }

  void _performAttack(Attack attack) {
    int damageValue = int.parse(attack.damage.split('/')[0]);

    setState(() {
      _bossDialogue = attack.dialogue2; // Level 2-specific dialogue
      currentScore += damageValue;
      highestScore = currentScore > highestScore ? currentScore : highestScore;

      _bossHealth -= damageValue;

      if (_bossHealth <= 50 && _bossHealth > 0) {
        _bossHealth = 50; // Freeze health at 50
        _showGameOverPopup();
      } else if (_bossHealth <= 0) {
        _bossHealth = 0;
        _showWinnerPopup();
      }
    });

    _startHealthRegenTimer();

    // Clear dialogue after a delay
    Future.delayed(const Duration(seconds: 5), () {
      setState(() {
        _bossDialogue = null;
      });
    });
  }

  void _showGameOverPopup() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Text("Game Over!", textAlign: TextAlign.center),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              "The boss has regained its strength! Try again.",
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8.0),
            Text("Score: $currentScore"),
            const SizedBox(height: 4.0),
            Text("High Score: $highestScore"),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  icon: const Icon(Icons.home, size: 32),
                  onPressed: () =>
                      Navigator.of(context).pushNamedAndRemoveUntil(
                    '/',
                    (route) => false,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.restart_alt, size: 32),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showWinnerPopup() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Text("Congratulations!", textAlign: TextAlign.center),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "You defeated the boss!\nYour Score: $currentScore",
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  icon: const Icon(Icons.home, size: 32),
                  onPressed: () =>
                      Navigator.of(context).pushNamedAndRemoveUntil(
                    '/',
                    (route) => false,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.restart_alt, size: 32),
                  onPressed: () =>
                      Navigator.of(context).pushNamedAndRemoveUntil(
                    '/game',
                    (route) => false,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Level 2"),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              // Placeholder for settings logic
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
                  icon: Icon(isMusicOn ? Icons.volume_up : Icons.volume_off),
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
                  child: Image.asset('lib/assets/images/boss2.jpg'),
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
              attacks: level2Attacks,
            ),
          ),
        ],
      ),
    );
  }
}
