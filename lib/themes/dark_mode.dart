import 'package:flutter/material.dart';

final ThemeData darkMode = ThemeData(
  brightness: Brightness.dark,
  colorScheme: ColorScheme.dark(
    primary: Color(0xFF3D5AFE),
    secondary: Color(0xFF5E6EFF),
    // ignore: deprecated_member_use
    background: Color(0xFF121212),
    surface: Color(0xFF1E1E1E),
    onPrimary: Colors.white,
    onSecondary: Colors.white,
    // ignore: deprecated_member_use
    onBackground: Colors.white70,
    onSurface: Colors.white70,
  ),
  useMaterial3: true,
);