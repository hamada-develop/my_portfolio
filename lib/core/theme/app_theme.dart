import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTheme {
  AppTheme._();

  static BoxDecoration glassDecoration(
    BuildContext context, {
    BorderRadius? borderRadius,
    List<Color>? gradientColors,
    bool isHovered = false,
  }) {
    final isLight = Theme.of(context).brightness == Brightness.light;
    final glassBg = isLight ? Colors.black.withValues(alpha: 0.03) : AppColors.glassBackground;
    final glassBgHover = isLight ? Colors.black.withValues(alpha: 0.06) : AppColors.glassBackgroundHover;
    final glassBorderColor = isLight ? Colors.black.withValues(alpha: 0.15) : AppColors.glassBorder;
    final shadowColor = isLight ? Colors.black.withValues(alpha: 0.1) : AppColors.purpleShadow;

    return BoxDecoration(
      color: isHovered
          ? glassBgHover
          : glassBg,
      borderRadius: borderRadius ?? BorderRadius.circular(16),
      border: Border.all(
        color: isHovered
            ? glassBorderColor.withValues(alpha: 0.8)
            : glassBorderColor,
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
                color: shadowColor,
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
