import 'package:flutter/material.dart';

const primaryColor = Color(0xFF1946BA);
const accentColor = Color(0xFF5EC0D5);

final theme = ThemeData(
  primaryColor: primaryColor,
  appBarTheme: const AppBarTheme(color: primaryColor),
  floatingActionButtonTheme:
      const FloatingActionButtonThemeData(backgroundColor: accentColor),
  textTheme: const TextTheme(
    headline3: TextStyle(fontSize: 36, fontWeight: FontWeight.w900),
    bodyText2: TextStyle(fontSize: 18),
  ).apply(
    bodyColor: primaryColor,
    displayColor: primaryColor,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      primary: primaryColor,
    ),
  ),
);
