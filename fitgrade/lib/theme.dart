import 'package:flutter/material.dart';
import 'theme_controller.dart';

class AppColors {
  // Static accent colors (same in both modes)
  static const Color accent = Color(0xFF7B2FF7);
  static const Color accentLight = Color(0xFFA855F7);
  static const Color green = Color(0xFF22C55E);
  static const Color orange = Color(0xFFF97316);

  // Dynamic colors based on dark mode
  static bool get _dark => ThemeController().isDarkMode;

  static Color get primary => _dark ? const Color(0xFF7B2FF7) : const Color(0xFF1A1A2E);
  static Color get background => _dark ? const Color(0xFF0D0D1A) : const Color(0xFFF0F2F5);
  static Color get card => _dark ? const Color(0xFF2C2C4E) : Colors.white;
  static Color get cardSecondary => _dark ? const Color(0xFF1E1E35) : const Color(0xFFF0F2F5);
  static Color get textPrimary => _dark ? Colors.white : const Color(0xFF1A1A2E);
  static Color get textSecondary => _dark ? const Color(0xFF9098A3) : const Color(0xFF9098A3);
  static Color get divider => _dark ? const Color(0xFF3D3D6B) : Colors.grey.shade100;
  static Color get greenBg => _dark ? const Color(0xFF0D2B1A) : const Color(0xFFEFFDF5);
  static Color get orangeBg => _dark ? const Color(0xFF2B1A0D) : const Color(0xFFFFF7ED);
  static Color get iconBg => _dark ? const Color(0xFF2C2C4E) : const Color(0xFFF0F2F5);
}

class AppTextStyles {
  static TextStyle heading1(BuildContext context) => TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.w800,
        color: AppColors.textPrimary,
      );

  static TextStyle heading2(BuildContext context) => TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w700,
        color: AppColors.textPrimary,
      );

  static TextStyle body(BuildContext context) => TextStyle(
        fontSize: 15,
        color: AppColors.textSecondary,
      );
}
