import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // Background Colors
  static const Color backgroundDark = Color(0xFF0F0A1E);
  static const Color backgroundDeep = Color(0xFF1A0B2E);
  static const Color backgroundPurple = Color(0xFF2D1B4E);

  // Primary Colors
  static const Color primaryPurple = Color(0xFF8B5CF6);
  static const Color primaryBlue = Color(0xFF3B82F6);
  static const Color primaryCyan = Color(0xFF06B6D4);
  static const Color primaryPink = Color(0xFFEC4899);

  // Accent Colors
  static const Color accentPurpleLight = Color(0xFFA78BFA);
  static const Color accentCyan = Color(0xFF22D3EE);
  static const Color accentBlue = Color(0xFF60A5FA);

  // Text Colors
  static const Color textPrimary = Color(0xFFFFFFFF);
  static const Color textSecondary = Color(0xFFD1D5DB);
  static const Color textTertiary = Color(0xFF9CA3AF);
  static const Color textMuted = Color(0xFF6B7280);

  // Glass Effect Colors
  static const Color glassBorder = Color(0x33A78BFA);
  static const Color glassBackground = Color(0x0DFFFFFF);
  static const Color glassBackgroundHover = Color(0x1AFFFFFF);

  // Gradients
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [primaryPurple, primaryBlue],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient cyanGradient = LinearGradient(
    colors: [primaryBlue, primaryCyan],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient purplePinkGradient = LinearGradient(
    colors: [primaryPurple, primaryPink, primaryCyan],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient textGradient = LinearGradient(
    colors: [accentPurpleLight, primaryCyan],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient backgroundGradient = LinearGradient(
    colors: [
      Color(0xFF1E1B4B), // Indigo-950
      Color(0xFF4C1D95), // Purple-950
      Color(0xFF0F172A), // Slate-900
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // Project Gradients
  static const LinearGradient projectGradient1 = LinearGradient(
    colors: [Color(0xFF7C3AED), Color(0xFF2563EB)],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

  static const LinearGradient projectGradient2 = LinearGradient(
    colors: [Color(0xFF2563EB), Color(0xFF06B6D4)],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

  static const LinearGradient projectGradient3 = LinearGradient(
    colors: [Color(0xFF06B6D4), Color(0xFF14B8A6)],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

  static const LinearGradient projectGradient4 = LinearGradient(
    colors: [Color(0xFF14B8A6), Color(0xFF10B981)],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

  // Shadow Colors
  static const Color purpleShadow = Color(0x4D8B5CF6);
  static const Color blueShadow = Color(0x4D3B82F6);
}