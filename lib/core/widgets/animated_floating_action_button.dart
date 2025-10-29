import 'package:flutter/material.dart';

class AnimatedFloatingActionButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final IconData icon;
  final String label;
  final bool isSmallScreen;

  const AnimatedFloatingActionButton({
    super.key,
    required this.icon,
    required this.label,
    required this.onPressed,
    required this.isSmallScreen,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: Duration(milliseconds: 300),
      transitionBuilder: (Widget child, Animation<double> animation) {
        return ScaleTransition(scale: animation, child: child);
      },
      child: isSmallScreen
          ? FloatingActionButton(
              key: ValueKey('small'),
              onPressed: onPressed,
              child: Icon(icon),
            )
          : FloatingActionButton.extended(
              key: ValueKey('extended'),
              onPressed: onPressed,
              icon: Icon(icon),
              label: Text(label),
            ),
    );
  }
}


class AnimatedFAB extends StatelessWidget {
  final bool isVisible;
  final VoidCallback onPressed;
  final IconData icon;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final String? heroTag;
  final Duration duration;

  const AnimatedFAB({
    super.key,
    required this.isVisible,
    required this.onPressed,
    this.icon = Icons.add,
    this.backgroundColor,
    this.foregroundColor,
    this.heroTag,
    this.duration = const Duration(milliseconds: 400),
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedScale(
      scale: isVisible ? 1.0 : 0.0,
      duration: duration,
      curve: Curves.easeInOut,
      child: AnimatedOpacity(
        opacity: isVisible ? 1.0 : 0.0,
        duration: duration,
        curve: Curves.easeInOut,
        child: FloatingActionButton(
          onPressed: isVisible ? onPressed : null,
          backgroundColor: backgroundColor,
          foregroundColor: foregroundColor,
          heroTag: heroTag,
          child: Icon(icon),
        ),
      ),
    );
  }
}
