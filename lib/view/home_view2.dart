import 'package:flutter/material.dart';

import '../core/animations.dart';
import '../core/widgets/disappearing_navigation_rail.dart';

class HomeView2 extends StatefulWidget {
  const HomeView2({super.key});

  @override
  State<HomeView2> createState() => _HomeView2State();
}

class _HomeView2State extends State<HomeView2>
    with SingleTickerProviderStateMixin {
  late final _colorScheme = Theme.of(context).colorScheme;

  late final _controller = AnimationController(
    duration: const Duration(milliseconds: 1000),
    reverseDuration: const Duration(milliseconds: 1250),
    value: 0,
    vsync: this,
  );

  late final _railAnimation = RailAnimation(parent: _controller);

  int selectedIndex = 0;

  bool controllerInitialized = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final double width = MediaQuery.of(context).size.width;
    final AnimationStatus status = _controller.status;
    if (width > 600) {
      if (status != AnimationStatus.forward &&
          status != AnimationStatus.completed) {
        _controller.forward();
      }
    } else {
      if (status != AnimationStatus.reverse &&
          status != AnimationStatus.dismissed) {
        _controller.reverse();
      }
    }
    if (!controllerInitialized) {
      controllerInitialized = true;
      _controller.value = width > 600 ? 1 : 0;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Scaffold(
          backgroundColor: _colorScheme.surfaceBright,
          body: Row(
            mainAxisAlignment: .center,
            children: [
              DisappearingNavigationRail(
                railAnimation: _railAnimation,
                selectedIndex: selectedIndex,
                backgroundColor: _colorScheme.surfaceBright,
                onDestinationSelected: (index) {},
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(top: 24, left: 16, right: 16),
                  decoration: BoxDecoration(
                    color: _colorScheme.surface,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
