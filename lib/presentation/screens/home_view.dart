import 'package:book/presentation/widgets/sections/cover_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/animations.dart';
import '../../../../core/widgets/animated_floating_action_button.dart';
import '../../../../core/widgets/disappearing_navigation_bottom.dart';
import '../../../../core/widgets/disappearing_navigation_rail.dart';
import '../controller/home_cubit.dart';
import '../widgets/home_content.dart';
import '../widgets/sections/about_section.dart';
import '../widgets/sections/contact_section.dart';
import '../widgets/sections/projects_section.dart';
import '../widgets/sections/skills_section.dart';
import '../widgets/sections/work_history_section.dart';

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
              Expanded(
                child: RepaintBoundary(
                  child: HomeContent(colorScheme: colorScheme),
                ),
              ),
            ],
          ),
          bottomNavigationBar: DisappearingNavigationBottom(
            selectedIndex: 0,
            onDestinationSelected: (index) {},
            backgroundColor: colorScheme.surfaceBright,
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

class HomeContent extends StatefulWidget {
  final ColorScheme colorScheme;
  const HomeContent({super.key, required this.colorScheme});

  @override
  State<HomeContent> createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent> {
  late final ScrollController _controller;

  // Global Keys for Scroll Targets
  final _sectionKeys = List.generate(5, (index) => GlobalKey());

  // Flag to break the feedback loop
  bool _isAutoScrolling = false;

  @override
  void initState() {
    super.initState();
    _controller = ScrollController();
    _controller.addListener(_onScroll);
  }

  @override
  void dispose() {
    _controller.removeListener(_onScroll);
    _controller.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isAutoScrolling) return;

    final threshold = MediaQuery.sizeOf(context).height * 0.4;
    final cubit = context.read<HomeCubit>();

    // Helper: Get Y position relative to viewport top
    double? getY(GlobalKey key) {
      final RenderBox? box = key.currentContext?.findRenderObject() as RenderBox?;
      return box?.localToGlobal(Offset.zero).dy;
    }

    // Check from bottom to top to see which section is "active"
    int newIndex = cubit.state.destination;

    // We iterate backwards (4 down to 0)
    for (int i = 4; i >= 0; i--) {
      final y = getY(_sectionKeys[i]);
      if (y != null && y <= threshold) {
        newIndex = i;
        break; // Found the active section
      }
    }

    if (newIndex != cubit.state.destination) {
      cubit.changeDestination(newIndex);
    }
  }

  Future<void> _scrollToSection(int index) async {
    final context = _sectionKeys[index].currentContext;
    if (context != null) {
      _isAutoScrolling = true;
      await Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeInOut,
        alignment: 0.0, // 0.0 = Align to top
      );
      _isAutoScrolling = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<HomeCubit, HomeState>(
      listenWhen: (previous, current) => previous.destination != current.destination,
      listener: (context, state) {
        if (_controller.hasClients && !_isAutoScrolling) {
          _scrollToSection(state.destination);
        }
      },
      child: Container(
        margin: const EdgeInsets.only(top: 24, left: 16, right: 16),
        decoration: BoxDecoration(
          color: widget.colorScheme.surface,
          borderRadius: const BorderRadius.all(Radius.circular(20)),
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          child: SingleChildScrollView(
            controller: _controller,
            padding: EdgeInsets.only(bottom: MediaQuery.sizeOf(context).height * 0.8),
            child: Column(
              children: [
                AboutSection(key: _sectionKeys[0]),
                ProjectsSection2(key: _sectionKeys[1]),
                WorkHistorySection2(key: _sectionKeys[2]), // Create this widget
                SkillsSection2(key: _sectionKeys[3]),      // Create this widget
                ContactSection2(key: _sectionKeys[4]),     // Create this widget
              ],
            ),
          ),
        ),
      ),
    );
  }
}



