import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/constants/app_constants.dart';

class GlassCard extends StatefulWidget {
  final Widget child;
  final EdgeInsets? padding;
  final BorderRadius? borderRadius;
  final Gradient? gradient;
  final bool enableHover;
  final VoidCallback? onTap;
  final double? width;
  final double? height;

  const GlassCard({
    super.key,
    required this.child,
    this.padding,
    this.borderRadius,
    this.gradient,
    this.enableHover = true,
    this.onTap,
    this.width,
    this.height,
  });

  @override
  State<GlassCard> createState() => _GlassCardState();
}

class _GlassCardState extends State<GlassCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final borderRadius = widget.borderRadius ??
        BorderRadius.circular(AppConstants.radiusLg);

    return MouseRegion(
      onEnter: widget.enableHover ? (_) => setState(() => _isHovered = true) : null,
      onExit: widget.enableHover ? (_) => setState(() => _isHovered = false) : null,
      cursor: widget.onTap != null ? SystemMouseCursors.click : SystemMouseCursors.basic,
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: AppConstants.animationNormal,
          curve: Curves.easeInOut,
          width: widget.width,
          height: widget.height,
          padding: widget.padding ?? const EdgeInsets.all(AppConstants.spacingLg),
          decoration: AppTheme.glassDecoration(
            context,
            borderRadius: borderRadius,
            isHovered: _isHovered,
          ),
          transform: _isHovered && widget.enableHover
              ? Matrix4.translationValues(0, -8, 0)
              : Matrix4.identity(),
          child: widget.child,
        ),
      ),
    );
  }
}

// Glass card with gradient border
class GlassCardWithGradientBorder extends StatefulWidget {
  final Widget child;
  final EdgeInsets? padding;
  final BorderRadius? borderRadius;
  final Gradient gradient;
  final bool enableHover;
  final VoidCallback? onTap;

  const GlassCardWithGradientBorder({
    super.key,
    required this.child,
    this.padding,
    this.borderRadius,
    required this.gradient,
    this.enableHover = true,
    this.onTap,
  });

  @override
  State<GlassCardWithGradientBorder> createState() =>
      _GlassCardWithGradientBorderState();
}

class _GlassCardWithGradientBorderState
    extends State<GlassCardWithGradientBorder> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final borderRadius = widget.borderRadius ??
        BorderRadius.circular(AppConstants.radiusLg);

    return MouseRegion(
      onEnter: widget.enableHover ? (_) => setState(() => _isHovered = true) : null,
      onExit: widget.enableHover ? (_) => setState(() => _isHovered = false) : null,
      cursor: widget.onTap != null ? SystemMouseCursors.click : SystemMouseCursors.basic,
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: AppConstants.animationNormal,
          curve: Curves.easeInOut,
          decoration: BoxDecoration(
            borderRadius: borderRadius,
            gradient: widget.gradient,
            boxShadow: _isHovered
                ? [
              BoxShadow(
                color: AppColors.purpleShadow,
                blurRadius: 24,
                offset: const Offset(0, 8),
              ),
            ]
                : null,
          ),
          transform: _isHovered && widget.enableHover
              ? Matrix4.translationValues(0, -8, 0)
              : Matrix4.identity(),
          child: Container(
            margin: const EdgeInsets.all(2),
            padding: widget.padding ?? const EdgeInsets.all(AppConstants.spacingLg),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: borderRadius,
            ),
            child: widget.child,
          ),
        ),
      ),
    );
  }
}