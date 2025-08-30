import 'dart:async';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import '../home_screen.dart';

class Splash1 extends StatefulWidget {
  const Splash1({super.key});

  @override
  State<Splash1> createState() => _Splash1State();
}

class _Splash1State extends State<Splash1> with SingleTickerProviderStateMixin {
  late VideoPlayerController _controller;
  late AnimationController _anim;
  late Animation<double> _fade;

  final String asset = 'assets/videos/splash1.mp4';
  final Duration showTime = const Duration(
      seconds: 5, microseconds: 200); // ← put your video length here

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset(asset)
      ..setLooping(true)
      ..setVolume(0);
    _anim = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _fade = Tween(begin: 0.0, end: 1.0)
        .animate(CurvedAnimation(parent: _anim, curve: Curves.easeOut));
    _initVideo();
  }

Future<void> _initVideo() async {
  try {
    await _controller.initialize();
    _controller.play();
    _anim.forward();
    setState(() {});
    Timer(showTime, () => _goHome());
  } catch (e) {
    // If anything fails, skip the video and go straight to Home
    debugPrint('Splash video error: $e');
    _goHome(); // always forward to Home
  }
}

  void _goHome() => Navigator.of(context).pushReplacement(
        PageRouteBuilder(
          pageBuilder: (_, __, ___) => const HomeScreen(),
          transitionsBuilder: (_, a, __, c) =>
              FadeTransition(opacity: a, child: c),
          transitionDuration: const Duration(milliseconds: 600),
        ),
      );

  @override
  void dispose() {
    _controller.dispose();
    _anim.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_controller.value.isInitialized) {
      return Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.pinkAccent, Colors.amberAccent],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: const Center(
          child: CircularProgressIndicator(color: Colors.white),
        ),
      );
    }

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Video
          FittedBox(
            fit: BoxFit.cover,
            child: SizedBox(
              width: _controller.value.size.width,
              height: _controller.value.size.height,
              child: VideoPlayer(_controller),
            ),
          ),
          // Gradient overlay (kept exactly as you wanted)
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.pinkAccent.withOpacity(.35),
                  Colors.amberAccent.withOpacity(.25),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          // Title block at the top-center
          SafeArea(
            child: Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: const EdgeInsets.only(top: 60),
                child: FadeTransition(
                  opacity: _fade,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Main title with glow
                      ShaderMask(
                        shaderCallback: (bounds) => const LinearGradient(
                          colors: [Colors.white, Colors.white70],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ).createShader(bounds),
                        child: const Text(
                          'CheckMate',
                          style: TextStyle(
                            fontSize: 34,
                            fontWeight: FontWeight.w800,
                            letterSpacing: 1.2,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(height: 6),
                      // Subtitle
                      const Text(
                        'Mind • Body • Spirit',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white70,
                          letterSpacing: 2.4,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      // Tiny sparkle icon above the subtitle
                      const SizedBox(height: 4),
                      const Icon(Icons.auto_awesome,
                          size: 16, color: Colors.white54),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
