import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTheme {
  AppTheme._();

  // Custom BoxDecoration for glass effect
  static BoxDecoration glassDecoration({
    BorderRadius? borderRadius,
    List<Color>? gradientColors,
    bool isHovered = false,
  }) {
    return BoxDecoration(
      color: isHovered
          ? AppColors.glassBackgroundHover
          : AppColors.glassBackground,
      borderRadius: borderRadius ?? BorderRadius.circular(16),
      border: Border.all(
        color: isHovered
            ? AppColors.glassBorder.withValues(alpha: 0.8)
            : AppColors.glassBorder,
        width: 1,
      ),
      gradient: gradientColors != null
          ? LinearGradient(
              colors: gradientColors,
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            )
          : null,
      boxShadow: isHovered
          ? [
              BoxShadow(
                color: AppColors.purpleShadow,
                blurRadius: 24,
                offset: const Offset(0, 8),
              ),
            ]
          : null,
    );
  }

  // Custom BoxDecoration for gradient borders
  static BoxDecoration gradientBorderDecoration({
    required Gradient gradient,
    BorderRadius? borderRadius,
    double borderWidth = 2,
  }) {
    return BoxDecoration(
      borderRadius: borderRadius ?? BorderRadius.circular(16),
      gradient: gradient,
    );
  }
}
