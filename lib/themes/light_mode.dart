import 'package:flutter/material.dart';

final ThemeData lightMode = ThemeData(
  brightness: Brightness.light,
  colorScheme: ColorScheme.light(
    primary: Color(0xFF1A2B6C),       // hoofdaccentkleur (navy)
    secondary: Color(0xFF3D5AFE),     // secundaire kleur (lichtblauw)
    // ignore: deprecated_member_use
    background: Colors.white,         // achtergrond (scaffold etc.)
    surface: Color(0xFFF3F4F6),       // cards, sheets, dialogen
    onPrimary: Colors.white,          // tekst op 'primary' (bijv. knoptekst)
    onSecondary: Colors.white,
    // ignore: deprecated_member_use
    onBackground: Colors.black87,
    onSurface: Colors.black87,
  ),
  useMaterial3: true, // als je Material 3 wil gebruiken
);