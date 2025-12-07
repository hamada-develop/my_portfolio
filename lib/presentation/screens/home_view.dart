import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/animations.dart';
import '../../../../core/widgets/animated_floating_action_button.dart';
import '../../../../core/widgets/disappearing_navigation_bottom.dart';
import '../../../../core/widgets/disappearing_navigation_rail.dart';
import '../controller/home_cubit.dart';
import '../widgets/home_content.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final RailAnimation _railAnimation;
  late final HomeCubit _homeCubit;

  @override
  void initState() {
    super.initState();
    _homeCubit = HomeCubit();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 350),
      reverseDuration: const Duration(milliseconds: 350),
      vsync: this,
    );
    _railAnimation = RailAnimation(parent: _controller);

    // Initialize controller value based on initial screen size
    WidgetsBinding.instance.addPostFrameCallback((_) {
      precacheImage(const AssetImage('assets/hamada.png'), context);
      final width = MediaQuery.sizeOf(context).width;
      _controller.value = width > 600 ? 1 : 0;
      _homeCubit.updateDeviceWidth(width);
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final double width = MediaQuery.sizeOf(context).width;
    _homeCubit.updateDeviceWidth(width);
  }

  @override
  void dispose() {
    _homeCubit.close();
    _controller.dispose();
    super.dispose();
  }

  void _animateRailBasedOnWidth(double width) {
    if (width > 600) {
      if (_controller.status != AnimationStatus.forward &&
          _controller.status != AnimationStatus.completed) {
        _controller.forward();
      }
    } else {
      if (_controller.status != AnimationStatus.reverse &&
          _controller.status != AnimationStatus.dismissed) {
        _controller.reverse();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return BlocProvider.value(
      value: _homeCubit,
      child: BlocListener<HomeCubit, HomeState>(
        listenWhen: (previous, current) =>
            previous.deviceWide != current.deviceWide,
        listener: (context, state) {
          // Animate rail based on device width changes
          final width = MediaQuery.sizeOf(context).width;
          _animateRailBasedOnWidth(width);
        },
        child: Scaffold(
          backgroundColor: colorScheme.surfaceBright,
          body: Row(
            children: [
              // Navigation Rail - only rebuilds when destination changes
              RepaintBoundary(
                child: AnimatedBuilder(
                  animation: _controller,
                  builder: (context, child) {
                    return BlocSelector<HomeCubit, HomeState, int>(
                      selector: (state) => state.destination,
                      builder: (context, destination) {
                        return DisappearingNavigationRail(
                          railAnimation: _railAnimation,
                          selectedIndex: destination,
                          backgroundColor: colorScheme.surfaceBright,
                          onDestinationSelected: _homeCubit.changeDestination,
                        );
                      },
                    );
                  },
                ),
              ),
              // Main Content - isolated from navigation changes
              Expanded(
                child: RepaintBoundary(
                  child: _ContentContainer(colorScheme: colorScheme),
                ),
              ),
            ],
          ),
          bottomNavigationBar: DisappearingNavigationBottom(
            selectedIndex: 0,
            onDestinationSelected: (index) {
            }, backgroundColor: colorScheme.surfaceBright,
          ),
          floatingActionButton: RepaintBoundary(
            child: BlocSelector<HomeCubit, HomeState, DeviceWide>(
              selector: (state) => state.deviceWide,
              builder: (context, deviceWide) {
                return Padding(
                  padding: const EdgeInsetsDirectional.only(end: 20),
                  child: AnimatedFAB(
                    onPressed: () {},
                    icon: Icons.download,
                    isVisible: deviceWide == DeviceWide.small,
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

}

class _ContentContainer extends StatelessWidget {
  final ColorScheme colorScheme;

  const _ContentContainer({required this.colorScheme});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 24, left: 16, right: 16),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: const BorderRadius.all(Radius.circular(20)),
      ),
      child: const HomeContent(),
    );
  }
}

