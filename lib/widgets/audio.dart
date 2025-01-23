import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class Audio extends StatefulWidget {
  final bool isMusicOn;
  final String musicUrl; // URL for web-based audio
  final ValueChanged<bool> onToggle;

  const Audio({
    Key? key,
    required this.isMusicOn,
    required this.musicUrl,
    required this.onToggle,
  }) : super(key: key);

  @override
  _AudioState createState() => _AudioState();
}

class _AudioState extends State<Audio> {
  late AudioPlayer _audioPlayer;

  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer();
    _initializeMusic();
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(Audio oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.isMusicOn != widget.isMusicOn) {
      _toggleMusic();
    }
  }

  Future<void> _initializeMusic() async {
    try {
      await _audioPlayer.setLoopMode(LoopMode.all);
      if (widget.isMusicOn) {
        await _audioPlayer.setUrl(widget.musicUrl); // Set the source
        await _audioPlayer.play(); // Start playing
      }
    } catch (e) {
      debugPrint('Error initializing music: $e');
    }
  }

  Future<void> _toggleMusic() async {
    try {
      if (widget.isMusicOn) {
        await _audioPlayer.pause(); // Pause if music is currently on
      } else {
        await _audioPlayer.setUrl(widget.musicUrl); // Reset source
        await _audioPlayer.play(); // Play if music is off
      }
      widget.onToggle(!widget.isMusicOn); // Notify parent about toggle
    } catch (e) {
      debugPrint('Error toggling music: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        widget.isMusicOn ? Icons.music_note : Icons.music_off,
        color: widget.isMusicOn ? Colors.blue : Colors.grey,
      ),
      onPressed: _toggleMusic,
    );
  }
}
