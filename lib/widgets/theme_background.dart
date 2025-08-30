// lib/widgets/theme_background.dart
import 'package:flutter/material.dart';
import '../services/theme_bg_data.dart';
import '../services/theme_service.dart';

class ThemeBackground extends StatelessWidget {
  final Widget child;
  const ThemeBackground({required this.child, super.key});

// lib/widgets/theme_background.dart
@override
Widget build(BuildContext context) {
  // 1️⃣  ask for the extension type the theme actually provides
  final BackgroundData? ext =
    Theme.of(context).extension<BackgroundExtension>();

  if (ext == null) return child;

  return Stack(
    children: [
      Positioned.fill(
        child: Image.asset(
          ext.image,
          fit: BoxFit.cover,
          color: Colors.black.withOpacity(ext.opacity),
          colorBlendMode: BlendMode.dstATop,
        ),
      ),
      child,
    ],
  );
}
}