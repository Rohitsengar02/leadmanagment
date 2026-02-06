import 'package:flutter/material.dart';

// Use a ValueNotifier to manage the theme mode globally
final ValueNotifier<ThemeMode> themeModeNotifier = ValueNotifier(
  ThemeMode.dark,
);

class AppColors {
  // Dark Theme Palette
  static const Color backgroundDark = Color(0xFF000000);
  static const Color surfaceDark = Color(0xFF141414);
  static const Color cardBackgroundDark = Color(0xFF1C1C1E);
  static const Color textPrimaryDark = Color(0xFFFFFFFF);
  static const Color textSecondaryDark = Color(0xFFA1A1A1);

  // Light Theme Palette
  static const Color backgroundLight = Color(0xFFF2F2F7);
  static const Color surfaceLight = Color(0xFFFFFFFF);
  static const Color cardBackgroundLight = Color(0xFFE5E5EA);
  static const Color textPrimaryLight = Color(0xFF000000);
  static const Color textSecondaryLight = Color(0xFF636366);

  // Shared
  static const Color _primaryDarkColor = Color(0xFFFFD5A1); // Peach/Tan accent
  static const Color _primaryLightColor = Color(
    0xFFC79100,
  ); // Dark Golden for Light Mode

  static const Color accent = Color(0xFFE6C195);
  static const Color textTertiary = Color(0xFF8E8E93);

  // Status Colors
  static const Color hotLead = Color(0xFFFF4D4F);
  static const Color success = Color(0xFF34C759);
  static const Color warning = Color(0xFFFF9F0A);
  static const Color info = Color(0xFF0A84FF);

  // Custom Shapes Colors
  static const Color cardOrange = Color(0xFFFFD5A1);
  static const Color cardBlue = Color(0xFFB4C8FF);
  static const Color cardPurple = Color(0xFFD0B4FF);

  // Helper getters based on current theme mode
  static bool get isDarkMode => themeModeNotifier.value == ThemeMode.dark;

  static Color get background => isDarkMode ? backgroundDark : backgroundLight;
  static Color get surface => isDarkMode ? surfaceDark : surfaceLight;
  static Color get cardBackground =>
      isDarkMode ? cardBackgroundDark : cardBackgroundLight;
  static Color get textPrimary =>
      isDarkMode ? textPrimaryDark : textPrimaryLight;
  static Color get textSecondary =>
      isDarkMode ? textSecondaryDark : textSecondaryLight;

  // Dynamic Primary Color
  static Color get primary =>
      isDarkMode ? _primaryDarkColor : _primaryLightColor;
  static Color get primaryLight => isDarkMode
      ? const Color(0xFFFFE5C4)
      : const Color(
          0xFFFFE5C4,
        ); // Keep light variant similar or adjust if needed
}
