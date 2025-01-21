import 'dart:async';
import 'package:flutter/material.dart';
import 'game2.dart';
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
  int currentScore = 0;
  int highestScore = 0;
  bool isMusicOn = true;
  int _bossHealth = 100;
  Timer? _healthRegenTimer;
  late List<Attack> levelAttacks;

  @override
  void initState() {
    super.initState();
    // Initialize level-specific attacks (level 1 initially)
    levelAttacks = attacks.where((attack) => attack.level == 1).toList();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Level 1"),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {},
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
                    'lib/assets/images/boss.jpg',
                    fit: BoxFit.cover,
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
                Center(
                  child: Container(
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
              attacks: levelAttacks, // Dynamically updated based on the level
            ),
          ),
        ],
      ),
    );
  }

  void _performAttack(Attack attack) {
    int damageValue = int.parse(attack.damage.split('/')[0]);

    setState(() {
      _bossDialogue = attack.dialogue1;
      currentScore += damageValue;
      if (currentScore > highestScore) {
        highestScore = currentScore;
      }

      _bossHealth -= damageValue;
      if (_bossHealth < 0) _bossHealth = 0;
    });

    if (_bossHealth <= 50) {
      // Switch to level 2
      setState(() {
        levelAttacks = attacks
            .where((attack) => attack.level == 2)
            .toList(); // Replace attacks with level 2
      });

      // Navigate to game2.dart with level 2 data
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => Game2(
            currentScore: currentScore,
            highestScore: highestScore,
            isMusicOn: isMusicOn,
            bossHealth: _bossHealth,
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
}
