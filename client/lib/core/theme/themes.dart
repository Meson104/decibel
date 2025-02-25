import 'package:client/core/theme/app_palette.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static final darkThemeMode = ThemeData(
    fontFamily: 'Lato',
    brightness: Brightness.dark,
  ).copyWith(
    scaffoldBackgroundColor: Pallete.backgroundColor,
    inputDecorationTheme: const InputDecorationTheme(
        contentPadding: EdgeInsets.all(22),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Pallete.gradient2,
          ),
        ),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
          color: Pallete.borderColor,
        ))),
  );
}
