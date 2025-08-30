// lib/services/theme_service.dart
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'theme_bg_data.dart';

class ThemeService with ChangeNotifier {
  static const String _themeKey = 'selected_theme';
  late String _currentThemeName;

  /* ------------------------------------------------------------------
     FULL & SIMPLE VARIANTS FOR EVERY THEME
  ------------------------------------------------------------------ */
  final Map<String, ThemeData> _themes = {
    'Light Mode (simple)': _lightModeV2(full: false),
    /* ---------- DARK & COSMIC ---------- */
    'Dark Mode': _darkMode(full: true),
    'Galaxy Astronomy': _astronomy(full: true),

    /* ---------- PASTEL SUNSET ---------- */
    'Golden Paw': _sunsetDunes(full: true),

    /* ---------- ROSE & GOLD ---------- */
    'Rose Gold Glam': _roseGold(full: true),

    /* ---------- SOFT FLORALS ---------- */
    'Lavender Mist': _softLavender(full: true),
    'Blush Bloom': _girlyButterflyV2(full: true),
    'Cotton Candy': _cottonCandy(full: true),

    /* ---------- FRESH GREENS ---------- */
    'Kiwi Breeze': _greenKiwiV2(full: true),

    /* ---------- SKY BLUES ---------- */
    '3 Bears': _blueSkyV2(full: true),
    'Flower Blue': _lightModeV2(full: true),

    /* ---------- PLAYFUL ---------- */
    'Bata': _kids(full: true),
    'SpongeBob': _spongebob(full: true),
    'Gumball': _gumbul(full: true),



    /* ---------- NEW THEMES ---------- */

    'Harry Potter': _harryPotter(full: true),
    'Palestine': _palestine(full: true),
    'Engineering': _engineering(full: true),
    'Miraculous Ladybug': _miraculousLadybug(full: true), // Added Miraculous theme

        /* ---------- HEROES ---------- */
    'BatMan': _batman(full: true),
    'SpiderMAn': _spiderMan(full: true),
    'Arcane': _arcane(full: true),
    'One Piece': _onePiece(full: true),
  };

  ThemeService() {
    _currentThemeName = 'Light Mode (simple)';
  }

  Future<void> initialize() async {
    final prefs = await SharedPreferences.getInstance();
    final stored = prefs.getString(_themeKey);
    _currentThemeName =
        _themes.containsKey(stored) ? stored! : 'Light Mode (simple)';
    notifyListeners();
  }

  ThemeData get currentTheme => _themes[_currentThemeName]!;
  String get currentThemeName => _currentThemeName;
  List<String> get themeNames => _themes.keys.toList();

  Future<void> setTheme(String themeName) async {
    if (_themes.containsKey(themeName)) {
      _currentThemeName = themeName;
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_themeKey, themeName);
      notifyListeners();
    }
  }

  static bool isDark(String name) =>
      name.contains('Dark') ||
      name.contains('Neon') ||
      name.contains('Deep') ||
      name.contains('Amethyst') ||
      name.contains('Astronomy') ||
      name.contains('Marauder') || // Harry Potter theme is dark
      name.contains('Numerical'); // Numerical theme is dark

  /* ------------------------------------------------------------------
     BUILDERS  (each accepts {bool full} to toggle image)
  ------------------------------------------------------------------ */
  static BackgroundExtension? _bg(String? path, double opacity) =>
      path == null ? null : BackgroundExtension(image: path, opacity: opacity);

  /* ---- DARK ---- */
  static ThemeData _darkMode({bool full = true}) {
    const scaffold = Color(0xFF1A1A1C);
    const appBar = Color(0xFF252529);
    const card = Color(0x22FFFFFF);
    const text = Color(0xFFE8E6E3);
    const title = Color(0xFFB0A99F); // warm greige

    return ThemeData.dark().copyWith(
      scaffoldBackgroundColor: scaffold,
      primaryColor: title,
      cardColor: card,
      dialogBackgroundColor: card,
      textTheme: TextTheme(
        bodyLarge: TextStyle(color: text.withOpacity(.82)),
        bodyMedium: TextStyle(color: text.withOpacity(.82)),
        titleLarge: TextStyle(color: title, fontWeight: FontWeight.w500),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: appBar,
        foregroundColor: const Color.fromARGB(255, 0, 0, 0),
        elevation: 0,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(22)),
        ),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: title.withOpacity(.9),
        foregroundColor: scaffold,
      ),
      colorScheme: ColorScheme.dark(
        primary: title,
        secondary: const Color(0xFFA0958A),
        surface: card,
        background: scaffold,
      ),
      extensions: [
        if (full) _bg('assets/themes/dark_mode.jpg', 0.35)!,
      ],
    );
  }

  static ThemeData _kids({bool full = true}) => ThemeData(
        primaryColor: const Color(0xFFFFC9D8), // soft pink
        scaffoldBackgroundColor: const Color(0xFFFFFDF7),
        cardColor: const Color(0xFFFFFFFF),
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Color(0xFF4F4F61)),
          bodyMedium: TextStyle(color: Color(0xFF4F4F61)),
          titleLarge:
              TextStyle(color: Color(0xFF7B6FC9), fontWeight: FontWeight.w600),
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: const Color(0xFFFFC9D8), // baby-blue bar
          foregroundColor: const Color(0xFF4F4F61),
          elevation: 0,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(26)),
          ),
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Color(0xFFFFE194), // butter-yellow
          foregroundColor: Color(0xFF4F4F61),
        ),
        colorScheme: ColorScheme.light(
          primary: const Color(0xFFFFC9D8),
          secondary: const Color(0xFFB5EAEA),
          surface: Colors.white,
          background: const Color(0xFFFFFDF7),
        ),
        extensions: [
          if (full) _bg('assets/themes/kids.jpg', 0.8)!,
        ],
      );

  static ThemeData _astronomy({bool full = true}) => ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF0A0A1A),
        primaryColor: const Color(0xFF9F84FF),
        cardColor: const Color(0x1AFFFFFF),
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Color(0xFFD4D4FF)),
          bodyMedium: TextStyle(color: Color(0xFFD4D4FF)),
          titleLarge: TextStyle(
              color: Color.fromARGB(255, 255, 132, 132),
              fontWeight: FontWeight.w700),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF13132A),
          foregroundColor: Color.fromARGB(255, 0, 0, 0),
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(18)),
          ),
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Color(0xFF9F84FF),
          foregroundColor: Color(0xFF0A0A1A),
        ),
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFF9F84FF),
          secondary: Color(0xFF9F84FF),
          surface: Color(0x1AFFFFFF),
          background: Color(0xFF0A0A1A),
        ),
        extensions: [
          if (full) _bg('assets/themes/astronomy.jpg', 0.2)!,
        ],
      );

  /* ---- LIGHT THEMES ---- */
  static ThemeData _roseGold({bool full = true}) => ThemeData(
        primaryColor: const Color(0xFFFF69B4), // vivid pink
        scaffoldBackgroundColor: const Color(0xFFFFF2F7),
        cardColor: const Color(0xFFFFFFFF),
        textTheme: TextTheme(
          bodyLarge: const TextStyle(color: Color(0xFF8B004B)),
          bodyMedium: const TextStyle(color: Color(0xFF8B004B)),
          titleLarge: const TextStyle(
            color: Color(0xFFFFD700), // rich gold
            fontWeight: FontWeight.w700,
          ),
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: const Color(0xFFFF69B4),
          foregroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(24)),
          ),
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Color(0xFFFFD700), // gold button
          foregroundColor: Color(0xFF8B004B),
        ),
        colorScheme: ColorScheme.light(
          primary: const Color(0xFFFF69B4),
          secondary: const Color(0xFFFFD700),
          surface: Colors.white,
          background: const Color(0xFFFFF2F7),
        ),
        extensions: [
          if (full) _bg('assets/themes/rose_gold.jpg', 0.2)!,
        ],
      );

  static ThemeData _blueSkyV2({bool full = true}) => ThemeData(
        primaryColor: const Color(0xFF29B6F6),
        scaffoldBackgroundColor: const Color.fromARGB(255, 255, 255, 255),
        cardColor: Colors.white,
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Color(0xFF0D47A1)),
          bodyMedium: TextStyle(color: Color(0xFF0D47A1)),
          titleLarge:
              TextStyle(color: Color(0xFF0D47A1), fontWeight: FontWeight.bold),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF29B6F6),
          foregroundColor: Color(0xFF0D47A1),
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(15)),
          ),
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Color(0xFF29B6F6),
          foregroundColor: Colors.white,
        ),
        colorScheme: ColorScheme.light(
          primary: const Color(0xFF29B6F6),
          secondary: const Color(0xFF81D4FA),
          surface: Colors.white,
          background: const Color(0xFFE3F2FD),
        ),
        extensions: [
          if (full) _bg('assets/themes/3Bears.jpg', 0.5)!,
        ],
      );

  static ThemeData _sunsetDunes({bool full = true}) => ThemeData(
        primaryColor: const Color(0xFFFF7043), // vivid orange
        scaffoldBackgroundColor: const Color(0xFFFFF8E1),
        cardColor: Colors.white,
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Color(0xFFD84315)),
          bodyMedium: TextStyle(color: Color(0xFFD84315)),
          titleLarge:
              TextStyle(color: Color(0xFFBF360C), fontWeight: FontWeight.bold),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: const Color(0xFFFF7043),
          foregroundColor: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(15)),
          ),
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Color(0xFFFF8A65),
          foregroundColor: Colors.white,
        ),
        colorScheme: ColorScheme.light(
          primary: const Color(0xFFFF7043),
          secondary: const Color(0xFFFFAB91),
          surface: Colors.white,
          background: const Color(0xFFFFF8E1),
        ),
        extensions: [
          if (full) _bg('assets/themes/sunset_dunes.jpg', 0.38)!,
        ],
      );

  static ThemeData _cottonCandy({bool full = true}) => ThemeData(
        primaryColor: const Color(0xFF9B59B6),
        secondaryHeaderColor: const Color(0xFFCE93D8),
        scaffoldBackgroundColor: const Color(0xFFF3E5F5),
        cardColor: Colors.white,
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Color(0xFF7B1FA2)),
          bodyMedium: TextStyle(color: Color(0xFF7B1FA2)),
          titleLarge:
              TextStyle(color: Color(0xFF9C27B0), fontWeight: FontWeight.bold),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF9B59B6),
          foregroundColor: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(15)),
          ),
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Color(0xFF9B59B6),
          foregroundColor: Colors.white,
        ),
        colorScheme: ColorScheme.light(
          primary: const Color(0xFF9B59B6),
          secondary: const Color(0xFFF9C7D4),
          surface: Colors.white,
          background: const Color(0xFFF3E5F5),
        ),
        extensions: [
          if (full) _bg('assets/themes/cotton_candy.jpg', 0.4)!,
        ],
      );

  static ThemeData _lightModeV2({bool full = true}) => ThemeData(
        primaryColor: const Color(0xFF2196F3),
        scaffoldBackgroundColor: Colors.white,
        cardColor: Colors.white,
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Color(0xFF212121)),
          bodyMedium: TextStyle(color: Color(0xFF212121)),
          titleLarge:
              TextStyle(color: Color(0xFF2196F3), fontWeight: FontWeight.bold),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF2196F3),
          foregroundColor: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(15)),
          ),
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Color(0xFF2196F3),
          foregroundColor: Colors.white,
        ),
        colorScheme: ColorScheme.light(
          primary: const Color(0xFF2196F3),
          secondary: const Color(0xFF90CAF9),
          surface: Colors.white,
          background: Colors.white,
        ),
        extensions: [
          if (full) _bg('assets/themes/light_mode.jpg', 0.4)!,
        ],
      );

  static ThemeData _greenKiwiV2({bool full = true}) => ThemeData(
        primaryColor: const Color(0xFF7CB342),
        scaffoldBackgroundColor: const Color(0xFFF3FBF1),
        cardColor: Colors.white,
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Color(0xFF33691E)),
          bodyMedium: TextStyle(color: Color(0xFF33691E)),
          titleLarge:
              TextStyle(color: Color(0xFF33691E), fontWeight: FontWeight.bold),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF7CB342),
          foregroundColor: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(15)),
          ),
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Color(0xFF7CB342),
          foregroundColor: Colors.white,
        ),
        colorScheme: ColorScheme.light(
          primary: const Color(0xFF7CB342),
          secondary: const Color(0xFFAED581),
          surface: Colors.white,
          background: const Color(0xFFF3FBF1),
        ),
        extensions: [
          if (full) _bg('assets/themes/green_kiwi.jpg', 0.08)!,
        ],
      );

  static ThemeData _girlyButterflyV2({bool full = true}) => ThemeData(
        primaryColor: const Color(0xFFFF80AB),
        scaffoldBackgroundColor: const Color(0xFFFFF8F9),
        cardColor: Colors.white,
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Color(0xFFAD1457)),
          bodyMedium: TextStyle(color: Color(0xFFAD1457)),
          titleLarge:
              TextStyle(color: Color(0xFFAD1457), fontWeight: FontWeight.bold),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFFFF80AB),
          foregroundColor: Color(0xFFAD1457),
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(15)),
          ),
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Color(0xFFFF80AB),
          foregroundColor: Color(0xFFAD1457),
        ),
        colorScheme: ColorScheme.light(
          primary: const Color(0xFFFF80AB),
          secondary: const Color(0xFFF8BBD9),
          surface: Colors.white,
          background: const Color(0xFFFFF8F9),
        ),
        extensions: [
          if (full) _bg('assets/themes/girly_butterfly.jpg', 0.18)!,
        ],
      );

  static ThemeData _softLavender({bool full = true}) => ThemeData(
        primaryColor: const Color(0xFFB39DDB),
        scaffoldBackgroundColor: const Color(0xFFF6F2FF),
        cardColor: Colors.white,
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Color(0xFF512DA8)),
          bodyMedium: TextStyle(color: Color(0xFF512DA8)),
          titleLarge:
              TextStyle(color: Color(0xFF512DA8), fontWeight: FontWeight.bold),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFFB39DDB),
          foregroundColor: Color(0xFF512DA8),
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(15)),
          ),
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Color(0xFFB39DDB),
          foregroundColor: Color(0xFF512DA8),
        ),
        colorScheme: ColorScheme.light(
          primary: const Color(0xFFB39DDB),
          secondary: const Color(0xFFD1C4E9),
          surface: Colors.white,
          background: const Color(0xFFF6F2FF),
        ),
        extensions: [
          if (full) _bg('assets/themes/soft_lavender.jpg', 0.3)!,
        ],
      );

  /* ------------------------------------------------------------------
     EXISTING THEMES
  ------------------------------------------------------------------ */

  /* ----------  Spongebob Theme  ---------- */
  static ThemeData _spongebob({bool full = true}) => ThemeData(
        primaryColor: const Color(0xFFFFD700),
        scaffoldBackgroundColor: const Color.fromARGB(242, 243, 236, 177),
        cardColor: Colors.white,
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Color.fromARGB(255, 235, 80, 183)),
          bodyMedium: TextStyle(color: Color.fromARGB(255, 219, 66, 181)),
          titleLarge:
              TextStyle(color: Color(0xFFF57F17), fontWeight: FontWeight.bold),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFFFFD700),
          foregroundColor: Color.fromARGB(255, 236, 94, 165),
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(15)),
          ),
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Color(0xFFF8BBD0),
          foregroundColor: Color(0xFFBF360C),
        ),
        colorScheme: ColorScheme.light(
          primary: const Color(0xFFFFD700),
          secondary: const Color(0xFFF8BBD0),
          surface: Colors.white,
          background: const Color(0xFFFFF59D),
        ),
        extensions: [
          if (full) _bg('assets/themes/spongebob.jpg', 0.28)!,
        ],
      );

  /* ----------  Gumbul Theme  ---------- */
  static ThemeData _gumbul({bool full = true}) => ThemeData(
        primaryColor: const Color(0xFF039BE5),
        scaffoldBackgroundColor: const Color.fromARGB(221, 225, 245, 254),
        cardColor: Colors.white,
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Color.fromARGB(255, 231, 105, 37)),
          bodyMedium: TextStyle(color: Color.fromARGB(255, 236, 110, 41)),
          titleLarge:
              TextStyle(color: Color.fromARGB(255, 243, 124, 60), fontWeight: FontWeight.bold),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF039BE5),
          foregroundColor: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(15)),
          ),
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Color(0xFFFF9800),
          foregroundColor: Colors.white,
        ),
        colorScheme: ColorScheme.light(
          primary: const Color(0xFF039BE5),
          secondary: const Color(0xFFFF9800),
          surface: Colors.white,
          background: const Color(0xFFE1F5FE),
        ),
        extensions: [
          if (full) _bg('assets/themes/gumball.jpg', 0.2)!,
        ],
      );

  /* ----------  Batman Theme  ---------- */
  static ThemeData _batman({bool full = true}) => ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colors.black,
        primaryColor: const Color(0xFFFFC400),
        cardColor: const Color(0x1AFFFFFF),
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Color(0xFFFFC400)),
          bodyMedium: TextStyle(color: Color(0xFFFFC400)),
          titleLarge:
              TextStyle(color: Color(0xFFFFC400), fontWeight: FontWeight.bold),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.black,
          foregroundColor: Color.fromARGB(255, 0, 0, 0),
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(15)),
          ),
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Color(0xFFFFC400),
          foregroundColor: Colors.black,
        ),
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFFFFC400),
          secondary: Color(0xFFFFC400),
          surface: Color(0x1AFFFFFF),
          background: Colors.black,
        ),
        extensions: [
          if (full) _bg('assets/themes/batman.jpg', 0.1)!,
        ],
      );

  /* ----------  Spider-Man Theme  ---------- */
  static ThemeData _spiderMan({bool full = true}) => ThemeData(
        primaryColor: const Color(0xFFD50000),
        scaffoldBackgroundColor: const Color.fromARGB(248, 245, 245, 245),
        cardColor: Colors.white,
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Color(0xFF0D47A1)),
          bodyMedium: TextStyle(color: Color(0xFF0D47A1)),
          titleLarge:
              TextStyle(color: Color(0xFFD50000), fontWeight: FontWeight.bold),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFFD50000),
          foregroundColor: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(15)),
          ),
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Color(0xFF0D47A1),
          foregroundColor: Colors.white,
        ),
        colorScheme: ColorScheme.light(
          primary: const Color(0xFFD50000),
          secondary: const Color(0xFF0D47A1),
          surface: Colors.white,
          background: const Color(0xFFF5F5F5),
        ),
        extensions: [
          if (full) _bg('assets/themes/spiderman.jpg', 0.5)!,
        ],
      );

  /* ----------  Arcane Theme  ---------- */
  static ThemeData _arcane({bool full = true}) => ThemeData(
        primaryColor: const Color(0xFF2196F3),
        scaffoldBackgroundColor: const Color(0xFFE3F2FD),
        cardColor: Colors.white,
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Color(0xFFB71C1C)),
          bodyMedium: TextStyle(color: Color(0xFFB71C1C)),
          titleLarge:
              TextStyle(color: Color(0xFFB71C1C), fontWeight: FontWeight.bold),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF2196F3),
          foregroundColor: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(15)),
          ),
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Color(0xFFB71C1C),
          foregroundColor: Colors.white,
        ),
        colorScheme: ColorScheme.light(
          primary: const Color(0xFF2196F3),
          secondary: const Color(0xFFB71C1C),
          surface: Colors.white,
          background: const Color(0xFFE3F2FD),
        ),
        extensions: [
          if (full) _bg('assets/themes/arcane.jpg', 0.1)!,
        ],
      );

  /* ----------  One Piece Theme  ---------- */
  static ThemeData _onePiece({bool full = true}) => ThemeData(
        primaryColor: const Color(0xFFFF80AB),
        scaffoldBackgroundColor: const Color(0xFFFFFDE7),
        cardColor: Colors.white,
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Color(0xFF6D4C41)),
          bodyMedium: TextStyle(color: Color(0xFF6D4C41)),
          titleLarge:
              TextStyle(color: Color(0xFF6D4C41), fontWeight: FontWeight.bold),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFFFF80AB),
          foregroundColor: Color.fromARGB(255, 255, 255, 255),
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(15)),
          ),
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Color(0xFFFFFDE7),
          foregroundColor: Color(0xFFFF80AB),
        ),
        colorScheme: ColorScheme.light(
          primary: const Color(0xFFFF80AB),
          secondary: const Color(0xFFFFFDE7),
          surface: Colors.white,
          background: const Color(0xFFFFFDE7),
        ),
        extensions: [
          if (full) _bg('assets/themes/onepiece.jpg', 0.4)!,
        ],
      );

  /* ------------------------------------------------------------------
     NEW THEMES
  ------------------------------------------------------------------ */

  /* ----------  Marauder's Map (Harry Potter) Theme  ---------- */
    static ThemeData _maraudersMap({bool full = true}) => ThemeData(
        primaryColor: const Color.fromARGB(255, 87, 50, 2), // Palestinian green
        scaffoldBackgroundColor: const Color(0xFFF5F5F5),
        cardColor: Colors.white,
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Color(0xFF000000)),
          bodyMedium: TextStyle(color: Color(0xFF000000)),
          titleLarge:
              TextStyle(color: Color(0xFF000000), fontWeight: FontWeight.bold),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color.fromARGB(255, 116, 76, 4),
          foregroundColor: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(15)),
          ),
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Color(0xFFCE1126), // Palestinian red
          foregroundColor: Colors.white,
        ),
        colorScheme: ColorScheme.light(
          primary: const Color.fromARGB(255, 122, 73, 0),
          secondary: const Color(0xFFCE1126),
          surface: Colors.white,
          background: const Color(0xFFF5F5F5),
        ),
        extensions: [
          if (full) _bg('assets/themes/marauders_map.jpg', 0.5)!,
        ],
      );

  /* ----------  Harry Potter Theme  ---------- */
  static ThemeData _harryPotter({bool full = true}) => ThemeData(
        primaryColor: const Color(0xFF7B1E1E), // Maroon
        scaffoldBackgroundColor: const Color(0xFFFDF6F6),
        cardColor: Colors.white,
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Color(0xFF5D4037)), // Dark brown text
          bodyMedium: TextStyle(color: Color(0xFF6D4C41)),
          titleLarge: TextStyle(
            color: Color(0xFF7B1E1E), // Maroon
            fontWeight: FontWeight.bold,
          ),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF7B1E1E),
          foregroundColor: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(15)),
          ),
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Color(0xFFFFD700), // Gold accent
          foregroundColor: Colors.black,
        ),
        colorScheme: ColorScheme.light(
          primary: const Color(0xFF7B1E1E), // Maroon
          secondary: const Color(0xFFFFD700), // Gold
          surface: Colors.white,
          background: const Color(0xFFFDF6F6),
        ),
        extensions: [
          if (full) _bg('assets/themes/marauders_map.jpg', 0.3)!,
        ],
      );

  /* ----------  Palestine Theme  ---------- */
  static ThemeData _palestine({bool full = true}) => ThemeData(
        primaryColor: const Color(0xFF007A3D), // Palestinian green
        scaffoldBackgroundColor: const Color(0xFFF5F5F5),
        cardColor: Colors.white,
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Color(0xFF000000)),
          bodyMedium: TextStyle(color: Color(0xFF000000)),
          titleLarge:
              TextStyle(color: Color(0xFF000000), fontWeight: FontWeight.bold),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF007A3D),
          foregroundColor: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(15)),
          ),
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Color(0xFFCE1126), // Palestinian red
          foregroundColor: Colors.white,
        ),
        colorScheme: ColorScheme.light(
          primary: const Color(0xFF007A3D),
          secondary: const Color(0xFFCE1126),
          surface: Colors.white,
          background: const Color(0xFFF5F5F5),
        ),
        extensions: [
          if (full) _bg('assets/themes/palestine.jpg', 0.5)!,
        ],
      );

  /* ----------  Engineering Theme  ---------- */
  static ThemeData _engineering({bool full = true}) => ThemeData(
        primaryColor: const Color(0xFF1565C0), // Engineering blue
        scaffoldBackgroundColor: const Color(0xFFEEEEEE),
        cardColor: Colors.white,
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Color(0xFF212121)),
          bodyMedium: TextStyle(color: Color(0xFF212121)),
          titleLarge:
              TextStyle(color: Color(0xFF1565C0), fontWeight: FontWeight.bold),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF1565C0),
          foregroundColor: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(15)),
          ),
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Color(0xFFE64A19), // Accent orange
          foregroundColor: Colors.white,
        ),
        colorScheme: ColorScheme.light(
          primary: const Color(0xFF1565C0),
          secondary: const Color(0xFFE64A19),
          surface: Colors.white,
          background: const Color(0xFFEEEEEE),
        ),
        extensions: [
          if (full) _bg('assets/themes/engineering.jpg', 0.5)!,
        ],
      );

static ThemeData _miraculousLadybug({bool full = true}) => ThemeData(
  primaryColor: const Color(0xFFE91E63), // Marinette's signature pink
  scaffoldBackgroundColor: const Color(0xFFFFF0F5), // Light pink background
  cardColor: const Color(0xFFFFFFFF),
  textTheme: const TextTheme(
    bodyLarge: TextStyle(color: Color(0xFF4A154B)), // Deep purple
    bodyMedium: TextStyle(color: Color(0xFF4A154B)),
    titleLarge: TextStyle(color: Color(0xFFD10047), fontWeight: FontWeight.bold), // Darker pink
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: Color(0xFFE91E63),
    foregroundColor: Colors.white,
    elevation: 0,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
    ),
    iconTheme: IconThemeData(color: Colors.white),
  ),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: Color(0xFF4A154B), // Deep purple
    foregroundColor: Colors.white,
  ),
  iconTheme: const IconThemeData(
    color: Color(0xFFE91E63),
  ),
  colorScheme: ColorScheme.light(
    primary: const Color(0xFFE91E63),
    secondary: const Color(0xFF4A154B),
    surface: Colors.white,
    background: const Color(0xFFFFF0F5),
  ),
  extensions: [
    if (full) _bg('assets/themes/miraculous_ladybug.jpg', 0.3)!,
  ],
);
}


/* ------------------------------------------------------------------
   SINGLE UNIVERSAL EXTENSION
------------------------------------------------------------------ */
class BackgroundExtension extends ThemeExtension<BackgroundExtension>
    implements BackgroundData {
  @override
  final String image;
  @override
  final double opacity;

  const BackgroundExtension({required this.image, required this.opacity});

  @override
  BackgroundExtension copyWith({String? image, double? opacity}) =>
      BackgroundExtension(
          image: image ?? this.image, opacity: opacity ?? this.opacity);

  @override
  BackgroundExtension lerp(
          ThemeExtension<BackgroundExtension>? other, double t) =>
      this;
}
