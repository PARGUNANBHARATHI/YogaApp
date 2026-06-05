import 'package:flutter/material.dart';

import '../constants/app_colors.dart';

class AppTheme {

  static ThemeData lightTheme = ThemeData(

    useMaterial3: true,

    scaffoldBackgroundColor:
        AppColors.background,

    fontFamily: 'Poppins',

    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
    ),

    textTheme: const TextTheme(

      headlineLarge: TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.bold,
        color: AppColors.textPrimary,
      ),

      bodyLarge: TextStyle(
        fontSize: 16,
        color: AppColors.textSecondary,
      ),
    ),
  );
}