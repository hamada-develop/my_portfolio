import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/constants/app_constants.dart';

// Primary button with gradient
class PrimaryButton extends StatefulWidget {
  final String text;
  final VoidCallback onPressed;
  final IconData? icon;
  final Gradient? gradient;
  final bool isLoading;

  const PrimaryButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.icon,
    this.gradient,
    this.isLoading = false,
  }) : super(key: key);

  @override
  State<PrimaryButton> createState() => _PrimaryButtonState();
}

class _PrimaryButtonState extends State<PrimaryButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: AppConstants.animationNormal,
        curve: Curves.easeInOut,
        decoration: BoxDecoration(
          gradient: widget.gradient ?? AppColors.primaryGradient,
          borderRadius: BorderRadius.circular(AppConstants.radiusMd),
          boxShadow: _isHovered
              ? [
            BoxShadow(
              color: AppColors.purpleShadow,
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
          ]
              : null,
        ),
        transform: _isHovered
            ? Matrix4.translationValues(0, -2, 0)
            : Matrix4.identity(),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: widget.isLoading ? null : widget.onPressed,
            borderRadius: BorderRadius.circular(AppConstants.radiusMd),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppConstants.spacingXl,
                vertical: AppConstants.spacingMd,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (widget.isLoading)
                    const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    )
                  else if (widget.icon != null)
                    Icon(
                      widget.icon,
                      color: Colors.white,
                      size: 20,
                    ),
                  if (widget.icon != null || widget.isLoading)
                    const SizedBox(width: AppConstants.spacingSm),
                  Text(
                    widget.text,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// Social icon button
class SocialIconButton extends StatefulWidget {
  final IconData icon;
  final VoidCallback onPressed;
  final String tooltip;

  const SocialIconButton({
    Key? key,
    required this.icon,
    required this.onPressed,
    required this.tooltip,
  }) : super(key: key);

  @override
  State<SocialIconButton> createState() => _SocialIconButtonState();
}

class _SocialIconButtonState extends State<SocialIconButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: widget.tooltip,
      child: MouseRegion(
        onEnter: (_) => setState(() => _isHovered = true),
        onExit: (_) => setState(() => _isHovered = false),
        child: AnimatedContainer(
          duration: AppConstants.animationNormal,
          curve: Curves.easeInOut,
          decoration: BoxDecoration(
            color: _isHovered
                ? AppColors.glassBackgroundHover
                : AppColors.glassBackground,
            shape: BoxShape.circle,
            border: Border.all(
              color: _isHovered
                  ? AppColors.glassBorder.withOpacity(0.8)
                  : AppColors.glassBorder,
              width: 1,
            ),
          ),
          transform: _isHovered
              ? (Matrix4.identity()..scale(1.1))
              : Matrix4.identity(),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: widget.onPressed,
              borderRadius: BorderRadius.circular(AppConstants.radiusFull),
              child: Padding(
                padding: const EdgeInsets.all(AppConstants.spacingMd),
                child: Icon(
                  widget.icon,
                  color: _isHovered
                      ? AppColors.accentPurpleLight
                      : AppColors.textSecondary,
                  size: 24,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// Chip/Tag button
class ChipButton extends StatelessWidget {
  final String label;
  final IconData? icon;
  final VoidCallback? onPressed;
  final Color? backgroundColor;

  const ChipButton({
    Key? key,
    required this.label,
    this.icon,
    this.onPressed,
    this.backgroundColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor ?? AppColors.primaryPurple.withOpacity(0.2),
        borderRadius: BorderRadius.circular(AppConstants.radiusFull),
        border: Border.all(
          color: AppColors.primaryPurple.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(AppConstants.radiusFull),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppConstants.spacingMd,
              vertical: AppConstants.spacingSm,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (icon != null) ...[
                  Icon(
                    icon,
                    size: 14,
                    color: AppColors.textSecondary,
                  ),
                  const SizedBox(width: AppConstants.spacingXs),
                ],
                Text(
                  label,
                  style: const TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Link button
class LinkButton extends StatefulWidget {
  final String text;
  final VoidCallback onPressed;
  final IconData? icon;

  const LinkButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.icon,
  }) : super(key: key);

  @override
  State<LinkButton> createState() => _LinkButtonState();
}

class _LinkButtonState extends State<LinkButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: InkWell(
        onTap: widget.onPressed,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              widget.text,
              style: TextStyle(
                color: _isHovered
                    ? AppColors.accentPurpleLight
                    : AppColors.primaryPurple,
                fontSize: 16,
                fontWeight: FontWeight.w600,
                decoration: _isHovered
                    ? TextDecoration.underline
                    : TextDecoration.none,
              ),
            ),
            if (widget.icon != null) ...[
              const SizedBox(width: AppConstants.spacingXs),
              Icon(
                widget.icon,
                size: 16,
                color: _isHovered
                    ? AppColors.accentPurpleLight
                    : AppColors.primaryPurple,
              ),
            ],
          ],
        ),
      ),
    );
  }
}