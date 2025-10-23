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
