import 'package:flutter/material.dart';

import '../animations.dart';
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
    final isSmallScreen = size.width < 1000;

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
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.menu),
              tooltip: 'Menu',
            ),
            const SizedBox(height: 8),
            // Wrap FAB in RepaintBoundary for isolated repaints
            RepaintBoundary(
              child: AnimatedFloatingActionButton(
                onPressed: () {
                  // Add download resume logic
                },
                icon: Icons.download,
                isSmallScreen: isSmallScreen,
                label: 'Download Resume',
              ),
            ),
          ],
        ),
        extended: !isSmallScreen,
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

// Your existing Destination class and list
class Destination {
  const Destination(this.icon, this.label);
  final IconData icon;
  final String label;
}

const List<Destination> destinations = <Destination>[
  Destination(Icons.home_rounded, 'Home'),
  Destination(Icons.person_rounded, 'About'),
  Destination(Icons.code_rounded, 'Projects'),
  Destination(Icons.work_rounded, 'Experience'),
  Destination(Icons.emoji_objects_rounded, 'Skills'),
  Destination(Icons.contact_mail_rounded, 'Contact'),
];