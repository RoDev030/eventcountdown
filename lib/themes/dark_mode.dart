import 'package:flutter/material.dart';

final ThemeData darkMode = ThemeData(
  brightness: Brightness.dark,
  colorScheme: ColorScheme.dark(
    primary: Color(0xFF8E3A59), // Deep rose pink for primary
    secondary: Color(0xFF6D214F), // Darker pink for secondary
    background: Color(0xFF2C1E2E), // Dark plum for background
    surface: Color(
      0xFF3E2C3A,
    ), // Slightly lighter plum for cards, sheets, dialogs
    onPrimary: Colors.white, // Text on primary
    onSecondary: Colors.white, // Text on secondary
    onBackground: Colors.white70, // Text on background
    onSurface: Colors.white70, // Text on surface
  ),
  useMaterial3: true,
);
