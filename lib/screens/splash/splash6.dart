import 'dart:async';
import 'package:flutter/material.dart';
import '../home_screen.dart';

class Splash6 extends StatefulWidget {
  const Splash6({super.key});

  @override
  State<Splash6> createState() => _Splash6State();
}

class _Splash6State extends State<Splash6> with SingleTickerProviderStateMixin {
  late AnimationController _anim;
  late Animation<double> _fade;
  final Duration showTime = const Duration(seconds: 3);

  @override
  void initState() {
    super.initState();
    _anim = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _fade = Tween(begin: 0.0, end: 1.0)
        .animate(CurvedAnimation(parent: _anim, curve: Curves.easeOut));
    
    _anim.forward();
    Timer(showTime, () => _goHome());
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
    _anim.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background image
          Image.asset(
            'assets/images/splash6.jpg', // Make sure to add this image to your assets
            fit: BoxFit.cover,
          ),
          // Gradient overlay (same as your video splashes)
          // Title block at the top-center
          SafeArea(
            child: Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: const EdgeInsets.only(top: 180),
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
                            fontSize: 44,
                            fontWeight: FontWeight.w800,
                            letterSpacing: 1.2,
                            color: Color.fromARGB(248, 255, 255, 255),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      // Subtitle
                      const Text(
                        'Mind • Body • Spirit',
                        style: TextStyle(
                          fontSize: 20,
                          color: Color.fromARGB(248, 255, 255, 255),
                          letterSpacing: 2.4,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      // Tiny sparkle icon above the subtitle
                      const SizedBox(height: 8),
                      const Icon(Icons.auto_awesome,
                          size: 22, color: Color.fromARGB(248, 255, 255, 255)),
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