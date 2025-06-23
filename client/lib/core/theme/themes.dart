import 'package:client/core/theme/app_palette.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static final darkThemeMode = ThemeData(
    fontFamily: 'Lato',
    brightness: Brightness.dark,
  ).copyWith(
      scaffoldBackgroundColor: Pallete.backgroundColor,
      inputDecorationTheme: InputDecorationTheme(
        contentPadding: const EdgeInsets.all(22),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Pallete.gradient2,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white24,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: Pallete.backgroundColor));
}
