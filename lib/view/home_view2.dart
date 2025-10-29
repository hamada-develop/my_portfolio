import 'package:book/view/controller/home_cubit.dart';
import 'package:book/view/widgets/home_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../core/animations.dart';
import '../core/widgets/animated_floating_action_button.dart';
import '../core/widgets/disappearing_navigation_rail.dart';

class HomeView2 extends StatefulWidget {
  const HomeView2({super.key});

  @override
  State<HomeView2> createState() => _HomeView2State();
}

class _HomeView2State extends State<HomeView2>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final RailAnimation _railAnimation;
  late ColorScheme _colorScheme;

  late final HomeCubit _homeCubit;

  int selectedIndex = 0;
  bool controllerInitialized = false;
  double _lastWidth = 0;

  @override
  void initState() {
    super.initState();
    _homeCubit = HomeCubit();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 350), // Faster, smoother
      reverseDuration: const Duration(milliseconds: 350), // Consistent speed
      value: 0,
      vsync: this,
    );
    _railAnimation = RailAnimation(parent: _controller);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _colorScheme = Theme.of(context).colorScheme;

    final double width = MediaQuery.sizeOf(context).width;

    // Avoid unnecessary animations on minor width changes
    if ((width - _lastWidth).abs() < 10 && controllerInitialized) {
      return;
    }
    _lastWidth = width;

    // Set initial state without animation
    if (!controllerInitialized) {
      controllerInitialized = true;
      _controller.value = width > 600 ? 1 : 0;
      return;
    }

    // Animate only when crossing the threshold
    print('test rebuild ..... ');
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
  }

  @override
  void dispose() {
    _homeCubit.close();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _homeCubit,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, _) {
          return Scaffold(
            backgroundColor: _colorScheme.surfaceBright,
            body: Row(
              children: [
                RepaintBoundary(
                  child: BlocBuilder<HomeCubit, HomeState>(
                    buildWhen: (previous, current) =>
                        previous.destination != current.destination,
                    builder: (context, state) {
                      return DisappearingNavigationRail(
                        railAnimation: _railAnimation,
                        selectedIndex: state.destination,
                        backgroundColor: _colorScheme.surfaceBright,
                        onDestinationSelected: (index) {
                          _homeCubit.changeDestination(index);
                        },
                      );
                    },
                  ),
                ),
                Expanded(
                  child: RepaintBoundary(
                    child: Container(
                      margin: const EdgeInsets.only(
                        top: 24,
                        left: 16,
                        right: 16,
                      ),
                      decoration: BoxDecoration(
                        color: _colorScheme.surface,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                        ),
                      ),
                      child: HomeContent(),
                    ),
                  ),
                ),
              ],
            ),
            floatingActionButton: RepaintBoundary(
              child: LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
                  return AnimatedFAB(
                    onPressed: () {},
                    icon: Icons.download,
                    isVisible: constraints.maxWidth < 600,
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
