import 'package:flutter/material.dart';

import '../../view/home_view2.dart';
import '../animations.dart';
import '../transitions/nav_rail_transition.dart';
import 'animated_floating_action_button.dart';

class DisappearingNavigationBottom extends StatelessWidget {
  const DisappearingNavigationBottom({
    super.key,
    required this.backgroundColor,
    required this.selectedIndex,
    this.onDestinationSelected,
  });

  final Color backgroundColor;
  final int selectedIndex;
  final ValueChanged<int>? onDestinationSelected;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final isSmallScreen = size.width < 600;

    return AnimatedBottomNavBar(
      isVisible: isSmallScreen,
      child: BottomNavigationBar(
        items: destinations.map((d) {
          return BottomNavigationBarItem(
            icon: Icon(d.icon,color: Colors.white,),
            label: d.label,
          );
        }).toList(),
      ),
    );
  }
}



class AnimatedBottomNavBar extends StatelessWidget {
  final bool isVisible;
  final Widget child;
  final Duration duration;
  final Curve curve;

  const AnimatedBottomNavBar({
    super.key,
    required this.isVisible,
    required this.child,
    this.duration = const Duration(milliseconds: 300),
    this.curve = Curves.easeInOut,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: duration,
      switchInCurve: curve,
      switchOutCurve: curve,
      transitionBuilder: (Widget child, Animation<double> animation) {
        return SizeTransition(
          sizeFactor: animation,
          axisAlignment: -1.0,
          child: SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0, 1),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          ),
        );
      },
      child: isVisible ? child : const SizedBox.shrink(),
    );
  }
}