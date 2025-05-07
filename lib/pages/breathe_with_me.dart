// BreatheWithMeScreen.dart
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:audioplayers/audioplayers.dart';

class BreatheWithMeScreen extends StatefulWidget {
  @override
  _BreatheWithMeScreenState createState() => _BreatheWithMeScreenState();
}

class _BreatheWithMeScreenState extends State<BreatheWithMeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  late Timer _timer;
  late AudioPlayer _audioPlayer;
  bool _isPlaying = false;
  String _phase = "Breathe In";
  String _affirmation = "You are safe.";
  bool _showUI = true;
  int _sessionSeconds = 0;
  late Timer _sessionTimer;

  final List<String> _affirmations = [
    "You are safe.",
    "Let go of today’s worries.",
    "This breath is just for you.",
    "You’re doing great.",
    "Feel the calm inside."
  ];

  @override
  void initState() {
    super.initState();

    _audioPlayer = AudioPlayer();
    _audioPlayer.setReleaseMode(ReleaseMode.loop);
    _audioPlayer.play(AssetSource('audio/ocean-waves.mp3')).then((_) {
      setState(() => _isPlaying = true);
    }).catchError((error) {
      print('Error playing audio: $error');
      setState(() => _isPlaying = false);
    });

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    );

    _animation = Tween<double>(begin: 100, end: 200).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    )..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          setState(() {
            _phase = "Hold";
            _affirmation = (_affirmations..shuffle()).first;
          });
          Future.delayed(Duration(seconds: 2), () {
            setState(() => _phase = "Breathe Out");
            _controller.reverse();
          });
        } else if (status == AnimationStatus.dismissed) {
          setState(() {
            _phase = "Hold";
            _affirmation = (_affirmations..shuffle()).first;
          });
          Future.delayed(Duration(seconds: 2), () {
            setState(() => _phase = "Breathe In");
            _controller.forward();
          });
        }
      });

    _controller.forward();
    _startSessionTimer();
  }

  void _toggleAudio() async {
    if (_isPlaying) {
      await _audioPlayer.pause();
    } else {
      await _audioPlayer.resume();
    }
    setState(() => _isPlaying = !_isPlaying);
  }

  void _startSessionTimer() {
    _sessionTimer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() => _sessionSeconds++);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _sessionTimer.cancel();
    _audioPlayer.stop();
    super.dispose();
  }

  String _formatDuration(int totalSeconds) {
    final minutes = (totalSeconds ~/ 60).toString().padLeft(2, '0');
    final seconds = (totalSeconds % 60).toString().padLeft(2, '0');
    return "$minutes:$seconds";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple.shade100,
      appBar: AppBar(
        title: const Text("Breathe With Me"),
        backgroundColor: Colors.purple.shade300,
        actions: [
          IconButton(
            icon: Icon(_isPlaying ? Icons.music_note : Icons.music_off),
            onPressed: _toggleAudio,
          ),
          IconButton(
            icon: Icon(_showUI ? Icons.visibility_off : Icons.visibility),
            onPressed: () => setState(() => _showUI = !_showUI),
          )
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedBuilder(
              animation: _animation,
              builder: (context, child) {
                return Container(
                  width: _animation.value,
                  height: _animation.value,
                  decoration: BoxDecoration(
                    color: _phase == "Breathe In"
                        ? Colors.blue.shade200
                        : _phase == "Hold"
                            ? const Color.fromARGB(255, 177, 137, 137)
                            : Colors.purple.shade200,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 20,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                );
              },
            ),
            const SizedBox(height: 30),
            if (_showUI) ...[
              Text(
                _phase,
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w600,
                  color: Colors.purple.shade800,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                _affirmation,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.purple.shade700,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                "Session: ${_formatDuration(_sessionSeconds)}",
                style: TextStyle(fontSize: 16, color: Colors.grey[700]),
              ),
            ]
          ],
        ),
      ),
    );
  }
}
