import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.system;

  ThemeMode get themeMode => _themeMode;

  void toggleTheme(bool isDark) {
    _themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
}

class AppTheme {
  // Day Mode Colors
  static const Color lightPrimary = Color(0xFF4A90E2); // Light Blue
  static const Color lightBackground = Colors.white;
  static const Color lightSecondary = Color(0xFF81C784); // Calm Green
  
  // Night Mode Colors
  static const Color darkPrimary = Color(0xFF1A237E); // Navy
  static const Color darkBackground = Color(0xFF121212); // Dark Grey
  static const Color darkSecondary = Color(0xFFFFAB91); // Light Orange

  static final ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    primaryColor: lightPrimary,
    scaffoldBackgroundColor: lightBackground,
    colorScheme: ColorScheme.light(
      primary: lightPrimary,
      secondary: lightSecondary,
      surface: Colors.grey[100]!,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: lightPrimary,
      foregroundColor: Colors.white,
      elevation: 0,
    ),
    cardTheme: CardTheme(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: Colors.white,
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    primaryColor: darkPrimary,
    scaffoldBackgroundColor: darkBackground,
    colorScheme: ColorScheme.dark(
      primary: darkPrimary,
      secondary: darkSecondary,
      surface: const Color(0xFF1E1E1E),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: darkPrimary,
      foregroundColor: Colors.white,
      elevation: 0,
    ),
    cardTheme: CardTheme(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: const Color(0xFF1E1E1E),
    ),
  );
}
