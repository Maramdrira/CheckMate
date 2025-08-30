// lib/main.dart
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:wings_and_things/services/theme_service.dart';
import 'models/task.dart';
import 'models/hydration.dart';
import 'models/prayer.dart';
import 'screens/splash/splash10.dart';

import 'screens/splash/splash5.dart';
import 'screens/splash/splash6.dart';
import 'screens/splash/splash7.dart';
import 'screens/splash/splash8.dart';
import 'screens/splash/splash9.dart';
import 'services/LanguageService.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(TaskAdapter());
  Hive.registerAdapter(HydrationSettingsAdapter());
  Hive.registerAdapter(PrayerTimeAdapter());
  await Hive.openBox<Task>('tasks');
  await Hive.openBox<HydrationSettings>('hydration');
  await Hive.openBox<PrayerTime>('prayers');

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final ThemeService _themeService = ThemeService();

  @override
  void initState() {
    super.initState();
    _themeService.initialize();
  }

Widget _randomSplash() {
  try {
    final rng = Random();
    switch (rng.nextInt(7)) { 
      case 0:
        return const Splash5();
      case 1:
        return const Splash7();
      case 2:
        return const Splash6();
      case 3:
        return const Splash8();
      case 4:
        return const Splash9();
      case 5:
        return const Splash10();
      default:
        return const Splash5();
    }
  } catch (e) {
    debugPrint('Splash screen error: $e');
    return const Splash5();
  }
}

  @override
  Widget build(BuildContext context) {
return MultiProvider(
  providers: [
    ChangeNotifierProvider.value(value: _themeService),
    ChangeNotifierProvider(create: (_) => LanguageService()),
  ],
  child: Consumer2<ThemeService, LanguageService>(
    builder: (context, themeService, langService, _) {
      return MaterialApp(
        title: 'CheckMate',
        theme: themeService.currentTheme,
        debugShowCheckedModeBanner: false,
        home: _randomSplash(),
        builder: (context, child) {
          return Directionality(
            textDirection: langService.direction,
            child: child!,
          );
        },
      );
    },
  ),
);
  }
}