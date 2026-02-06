import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants/app_colors.dart';

class AppTheme {
  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: AppColors.backgroundDark,
      colorScheme: ColorScheme.dark(
        primary: AppColors.primary,
        secondary: AppColors.accent,
        surface: AppColors.surfaceDark,
        onSurface: AppColors.textPrimaryDark,
      ),
      textTheme: _buildTextTheme(
        AppColors.textPrimaryDark,
        AppColors.textSecondaryDark,
      ),
      appBarTheme: _buildAppBarTheme(
        AppColors.backgroundDark,
        AppColors.textPrimaryDark,
      ),
      elevatedButtonTheme: _buildElevatedButtonTheme(),
    );
  }

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      scaffoldBackgroundColor: AppColors.backgroundLight,
      colorScheme: ColorScheme.light(
        primary: AppColors.primary,
        secondary: AppColors.accent,
        surface: AppColors.surfaceLight,
        onSurface: AppColors.textPrimaryLight,
      ),
      textTheme: _buildTextTheme(
        AppColors.textPrimaryLight,
        AppColors.textSecondaryLight,
      ),
      appBarTheme: _buildAppBarTheme(
        AppColors.backgroundLight,
        AppColors.textPrimaryLight,
      ),
      elevatedButtonTheme: _buildElevatedButtonTheme(),
    );
  }

  static TextTheme _buildTextTheme(Color primary, Color secondary) {
    return GoogleFonts.outfitTextTheme().copyWith(
      displayLarge: GoogleFonts.outfit(
        color: primary,
        fontWeight: FontWeight.bold,
      ),
      titleLarge: GoogleFonts.outfit(
        color: primary,
        fontWeight: FontWeight.bold,
      ),
      bodyLarge: GoogleFonts.outfit(color: primary),
      bodyMedium: GoogleFonts.outfit(color: secondary),
    );
  }

  static AppBarTheme _buildAppBarTheme(Color bgColor, Color textColor) {
    return AppBarTheme(
      backgroundColor: bgColor,
      elevation: 0,
      centerTitle: false,
      iconTheme: IconThemeData(color: textColor),
      titleTextStyle: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: textColor,
      ),
    );
  }

  static ElevatedButtonThemeData _buildElevatedButtonTheme() {
    return ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.black,
        minimumSize: const Size(double.infinity, 56),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
        textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
    );
  }
}
