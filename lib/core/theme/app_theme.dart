import 'package:flutter/material.dart';
import 'package:task_tejas/core/theme/text_theme.dart';

import '../constants/app_colors.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: AppColors.background,

    fontFamily: 'PlusJakartaSans',

    appBarTheme: const AppBarTheme(
      elevation: 0,

      backgroundColor: AppColors.background,

      foregroundColor: Colors.black,

      centerTitle: false,
    ),

    inputDecorationTheme: InputDecorationTheme(
      filled: true,

      fillColor: Colors.white,

      contentPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),

      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(18),

        borderSide: BorderSide(color: Colors.grey.shade300),
      ),

      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(18),

        borderSide: BorderSide(color: Colors.grey.shade300),
      ),

      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(18),

        borderSide: const BorderSide(color: Colors.black, width: 1.2),
      ),

      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(18),

        borderSide: const BorderSide(color: Colors.red),
      ),
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        elevation: 0,

        minimumSize: const Size(double.infinity, 56),

        backgroundColor: AppColors.primary,

        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),

        textStyle: AppTextTheme.buttonText,
      ),
    ),

    cardTheme: CardTheme(
      elevation: 0,

      color: Colors.white,

      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    ),
  );
}
