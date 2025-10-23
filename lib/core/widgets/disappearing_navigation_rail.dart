import 'package:flutter/material.dart';

import '../animations.dart';
import '../destinations.dart';
import '../transitions/nav_rail_transition.dart';
import 'animated_floating_action_button.dart';

class DisappearingNavigationRail extends StatelessWidget {
  const DisappearingNavigationRail({
    super.key,
    required this.railAnimation,
    required this.backgroundColor,
    required this.selectedIndex,
    this.onDestinationSelected,
  });

  final RailAnimation railAnimation;
  final Color backgroundColor;
  final int selectedIndex;
  final ValueChanged<int>? onDestinationSelected;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    bool isSmallScreen = size.width < 1000;

    return NavRailTransition(
      animation: railAnimation,
      backgroundColor: backgroundColor,
      child: NavigationRail(
        selectedIndex: selectedIndex,
        backgroundColor: backgroundColor,
        onDestinationSelected: onDestinationSelected,
        useIndicator: true,
        leading: Column(
          children: [
            IconButton(onPressed: () {}, icon: const Icon(Icons.menu)),
            const SizedBox(height: 8),
            AnimatedFloatingActionButton(
              onPressed: () {},
              icon: Icons.download,
              isSmallScreen: isSmallScreen,
              label: 'Download Resume',
            ),
          ],
        ),
        extended: isSmallScreen ? false : true,
        minExtendedWidth: 200,
        minWidth: 72,
        labelType: isSmallScreen
            ? NavigationRailLabelType.all
            : NavigationRailLabelType.none,
        groupAlignment: -0.85,
        destinations: destinations.map((d) {
          return NavigationRailDestination(
            icon: Icon(d.icon),
            label: Text(d.label),
          );
        }).toList(),
      ),
    );
  }
}
