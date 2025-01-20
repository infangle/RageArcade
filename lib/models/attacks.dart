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

  Attack({
    required this.name,
    required this.damage,
    required this.effect,
    required this.dialogue1,
    required this.dialogue2,
    required this.physicalEffect,
    required this.category,
    required this.icon,
  });
}

final List<Attack> attacks = [
  Attack(
    name: 'Banana Peel Slip',
    damage: '5/10',
    effect: 'The player places a banana peel under the boss’s seat.',
    dialogue1: '"What?! Who put this here?!"',
    dialogue2: '"I can’t move!"',
    physicalEffect: 'The boss is knocked onto the ground.',
    category: 'Sitting',
    icon: Icons.accessibility,
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
  ),
];
