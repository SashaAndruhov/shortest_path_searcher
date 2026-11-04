import 'package:flutter/material.dart';

ThemeData appTheme() => ThemeData(
  useMaterial3: false,
  primarySwatch: Colors.blue,
  scaffoldBackgroundColor: const Color(0xFFFAFAFA),
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.blue,
    foregroundColor: Colors.white,
    elevation: 4,
  ),
  progressIndicatorTheme: const ProgressIndicatorThemeData(color: Colors.blue),
);
