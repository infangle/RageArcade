import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class Audio extends StatefulWidget {
  final bool isMusicOn;
  final String musicUrl; // Updated to use a web-based URL
  final ValueChanged<bool> onToggle;

  const Audio({
    Key? key,
    required this.isMusicOn,
    required this.musicUrl, // Updated to accept a music URL
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

  Future<void> _initializeMusic() async {
    try {
      await _audioPlayer.setReleaseMode(ReleaseMode.loop);
      if (widget.isMusicOn) {
        await _audioPlayer
            .setSourceUrl(widget.musicUrl); // Use web-based audio source
        await _audioPlayer.resume();
      }
    } catch (e) {
      debugPrint('Error initializing music: $e');
    }
  }

  Future<void> _toggleMusic() async {
    try {
      if (widget.isMusicOn) {
        await _audioPlayer.pause();
      } else {
        await _audioPlayer.setSourceUrl(
            widget.musicUrl); // Ensure the URL is set before playing
        await _audioPlayer.resume();
      }
      widget.onToggle(!widget.isMusicOn); // Notify parent of the toggle state
    } catch (e) {
      debugPrint('Error toggling music: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        widget.isMusicOn ? Icons.music_note : Icons.music_off,
      ),
      onPressed: _toggleMusic,
    );
  }
}
