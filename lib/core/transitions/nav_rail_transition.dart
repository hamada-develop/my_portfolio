import 'package:flutter/material.dart';


class NavRailTransition extends StatefulWidget {
  const NavRailTransition({
    super.key,
    required this.animation,
    required this.backgroundColor,
    required this.child,
  });

  final Animation<double> animation;
  final Widget child;
  final Color backgroundColor;

  @override
  State<NavRailTransition> createState() => _NavRailTransitionState();
}

class _NavRailTransitionState extends State<NavRailTransition> {
  late final bool ltr = Directionality.of(context) == TextDirection.ltr;

  // Use easeInOutCubic for smoother animations
  late final Animation<Offset> offsetAnimation = Tween<Offset>(
    begin: ltr ? const Offset(-1, 0) : const Offset(1, 0),
    end: Offset.zero,
  ).animate(
    CurvedAnimation(
      parent: widget.animation,
      curve: Curves.easeInOutCubic, // Smoother curve
    ),
  );

  late final Animation<double> widthAnimation = Tween<double>(
    begin: 0,
    end: 1,
  ).animate(
    CurvedAnimation(
      parent: widget.animation,
      curve: Curves.easeInOutCubic, // Match the curve
    ),
  );

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: DecoratedBox(
        decoration: BoxDecoration(color: widget.backgroundColor),
        child: Align(
          alignment: Alignment.topLeft,
          widthFactor: widthAnimation.value,
          child: FractionalTranslation(
            translation: offsetAnimation.value,
            child: widget.child,
          ),
        ),
      ),
    );
  }
}
