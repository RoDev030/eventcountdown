import 'package:flutter/material.dart';

final ThemeData lightMode = ThemeData(
  brightness: Brightness.light,
  colorScheme: ColorScheme.light(
    primary: Color(0xFFFADADD), // Soft pink as primary color
    secondary: Color(0xFFF9A8D4), // Light rose pink for secondary
    background: Color(0xFFFFF1F3), // Very light pink for background
    surface: Color.fromARGB(
      255,
      248,
      248,
      248,
    ), // Slightly darker pink for cards, sheets, dialogs
    onPrimary: Colors.black, // Text on primary
    onSecondary: Colors.black, // Text on secondary
    onBackground: Colors.black87, // Text on background
    onSurface: Colors.black87, // Text on surface
  ),
  useMaterial3: true,
);
