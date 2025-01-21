import 'package:flutter/material.dart';

class Attack {
  final String name;
  final String damage;
  final String effect;
  final String dialogue1;
  final String dialogue2;
  final String physicalEffect;
  final String category; // 'Sitting' or 'Standing'
  final IconData icon;
  final int level; // Add this property to differentiate attacks by level

  Attack({
    required this.name,
    required this.damage,
    required this.effect,
    required this.dialogue1,
    required this.dialogue2,
    required this.physicalEffect,
    required this.category,
    required this.icon,
    required this.level,
  });
}

final List<Attack> attacks = [
  // Level 1 Attacks
  Attack(
    name: 'Banana Peel Slip',
    damage: '5/10',
    effect: 'The player places a banana peel under the boss’s seat.',
    dialogue1: '"What?! Who put this here?!"',
    dialogue2: '"I can’t move!"',
    physicalEffect: 'The boss is knocked onto the ground.',
    category: 'Sitting',
    icon: Icons.accessibility,
    level: 1,
  ),
  Attack(
    name: 'Selfie Stick Stab',
    damage: '2/10',
    effect: 'The player swings a giant selfie stick at the boss.',
    dialogue1: '"Hey, I was just about to take a selfie!"',
    dialogue2: '"What is wrong with you?!"',
    physicalEffect: 'Momentarily blinds the boss.',
    category: 'Standing',
    icon: Icons.camera,
    level: 1,
  ),
  Attack(
    name: 'Keyboard Smash',
    damage: '7/10',
    effect: 'The player smashes a keyboard over the boss’s head.',
    dialogue1: '"What was that for?!"',
    dialogue2: '"I can’t even type now!"',
    physicalEffect: 'The boss temporarily loses focus.',
    category: 'Standing',
    icon: Icons.computer,
    level: 1,
  ),
  Attack(
    name: 'Coffee Spill',
    damage: '4/10',
    effect: 'The player spills hot coffee on the boss.',
    dialogue1: '"Ouch! That’s hot!"',
    dialogue2: '"You’ll pay for this!"',
    physicalEffect: 'The boss slows down in rage.',
    category: 'Sitting',
    icon: Icons.local_cafe,
    level: 1,
  ),
  Attack(
    name: 'Paper Cut Fury',
    damage: '3/10',
    effect: 'The player gives the boss a nasty paper cut.',
    dialogue1: '"Why does it hurt so much?!"',
    dialogue2: '"This is worse than it looks!"',
    physicalEffect: 'The boss becomes overly cautious.',
    category: 'Standing',
    icon: Icons.description,
    level: 1,
  ),

  // Level 2 Attacks
  Attack(
    name: 'Bubble Wrap Bomb',
    damage: '10/10',
    effect:
        'The boss is surrounded by a bubble wrap explosion, forcing them into an awkward stance while they scramble to pop the bubbles.',
    dialogue1: '"These bubbles are driving me crazy!"',
    dialogue2: '"I can’t concentrate with all this noise!"',
    physicalEffect:
        'The boss stumbles around wildly, losing their balance for a short duration.',
    category: 'Standing',
    icon: Icons.bubble_chart,
    level: 2,
  ),
  Attack(
    name: 'Clown Car Chase',
    damage: '4/10',
    effect:
        'A tiny clown car zooms by, hitting the boss repeatedly and leaving them spinning.',
    dialogue1: '"Is this some kind of joke?!"',
    dialogue2: '"I can’t catch it! Stop that car!"',
    physicalEffect: 'The boss is left spinning and disoriented.',
    category: 'Standing',
    icon: Icons.toys,
    level: 2,
  ),
  Attack(
    name: 'Shoe-throwing Frenzy',
    damage: '6/10',
    effect:
        'The player throws shoes at the boss, who is overwhelmed by the barrage.',
    dialogue1: '"Why are you throwing shoes at me?!"',
    dialogue2: '"That’s it! I’m getting new shoes!"',
    physicalEffect: 'The boss is hit several times, slowing them down.',
    category: 'Standing',
    icon: Icons.shield,
    level: 2,
  ),
  Attack(
    name: 'Tickling Tornado',
    damage: '7/10',
    effect:
        'The boss is surrounded by a whirlwind of feather dusters and soft brushes, causing them to laugh uncontrollably.',
    dialogue1: '"Stop it! I can’t breathe!"',
    dialogue2: '"You’ve crossed the line!"',
    physicalEffect:
        'The boss falls to the ground in fits of laughter, making them vulnerable to further attacks.',
    category: 'Standing',
    icon: Icons.wind_power,
    level: 2,
  ),
  Attack(
    name: 'Giant Ice Cream Cone',
    damage: '4/10',
    effect:
        'The giant cone smashes into the boss, covering them with sticky ice cream that slows them down.',
    dialogue1: '"What is this? Ice cream?!"',
    dialogue2: '"I can’t move... it’s too cold!"',
    physicalEffect:
        'The ice cream makes the boss immobile for a brief period, lowering their defense.',
    category: 'Standing',
    icon: Icons.icecream,
    level: 2,
  ),
];
