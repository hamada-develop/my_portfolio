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

  // 1. Define Keys for all 5 sections
  final GlobalKey _aboutKey = GlobalKey();
  final GlobalKey _projectsKey = GlobalKey();
  final GlobalKey _workHistoryKey = GlobalKey();
  final GlobalKey _skillsKey = GlobalKey();
  final GlobalKey _contactKey = GlobalKey();

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

  // 2. Updated Scroll Logic for 5 items
  void _onScroll() {
    if (_isAutoScrolling) return;

    // Define the "snap point" (e.g., top 30% of screen)
    final double threshold = MediaQuery.sizeOf(context).height * 0.3;
    final cubit = context.read<HomeCubit>();

    // Helper to get Y position of a key
    double? getY(GlobalKey key) {
      final RenderBox? box = key.currentContext?.findRenderObject() as RenderBox?;
      return box?.localToGlobal(Offset.zero).dy;
    }

    final aboutY = getY(_aboutKey);
    final projectsY = getY(_projectsKey);
    final workY = getY(_workHistoryKey);
    final skillsY = getY(_skillsKey);
    final contactY = getY(_contactKey);

    // 3. Check Order: We determine the active section based on what is at the top.
    // We check sequentially. If 'Contact' is near the top, it wins.
    // NOTE: This simple logic assumes sections are tall enough.

    int newIndex = cubit.state.destination;

    if (contactY != null && contactY <= threshold) {
      newIndex = 4; // Contact
    } else if (skillsY != null && skillsY <= threshold) {
      newIndex = 3; // Skills
    } else if (workY != null && workY <= threshold) {
      newIndex = 2; // Work History
    } else if (projectsY != null && projectsY <= threshold) {
      newIndex = 1; // Projects
    } else if (aboutY != null && aboutY <= threshold) {
      newIndex = 0; // About
    }

    // Only update if changed
    if (newIndex != cubit.state.destination) {
      cubit.changeDestination(newIndex);
    }
  }

  Future<void> _scrollToSection(GlobalKey key) async {
    final context = key.currentContext;
    if (context != null) {
      _isAutoScrolling = true;
      await Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 800),
        curve: Curves.easeInOut,
        alignment: 0.0, // Align to top of screen
      );
      _isAutoScrolling = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<HomeCubit, HomeState>(
      listenWhen: (previous, current) => previous.destination != current.destination,
      listener: (context, state) async {
        if (_controller.hasClients && !_isAutoScrolling) {
          // 4. Map Index to Key
          switch (state.destination) {
            case 0: await _scrollToSection(_aboutKey); break;
            case 1: await _scrollToSection(_projectsKey); break;
            case 2: await _scrollToSection(_workHistoryKey); break;
            case 3: await _scrollToSection(_skillsKey); break;
            case 4: await _scrollToSection(_contactKey); break;
          }
        }
      },
      child: Container(
        margin: const EdgeInsets.only(top: 24, left: 16, right: 16),
        decoration: BoxDecoration(
          color: widget.colorScheme.surface,
          borderRadius: const BorderRadius.all(Radius.circular(20)),
        ),
        child: SingleChildScrollView(
          controller: _controller,
          padding: const EdgeInsets.only(bottom: 100), // Add padding for bottom scroll
          child: Column(
            children: [
              _AboutWidget(key: _aboutKey),
              _ProjectsWidget(key: _projectsKey),
              _WorkHistoryWidget(key: _workHistoryKey),
              _SkillsWidget(key: _skillsKey),
              _ContactWidget(key: _contactKey),
            ],
          ),
        ),
      ),
    );
  }
}


class _AboutWidget extends StatelessWidget {
  const _AboutWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.sizeOf(context).height,
      width: double.infinity,
      color: Colors.red,
      child: Center(
        child: Text('ABOUT WIDGET '),
      ),
    );
  }
}


class _ProjectsWidget extends StatelessWidget {
  const _ProjectsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 1000,
      width: double.infinity,
      color: Colors.green,
      child: Center(
        child: Text('PROJECTS WIDGET '),
      ),
    );
  }
}

class _WorkHistoryWidget extends StatelessWidget {
  const _WorkHistoryWidget({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 800, // Placeholder height
      width: double.infinity,
      color: Colors.blueGrey[100],
      child: const Center(child: Text('WORK HISTORY', style: TextStyle(fontSize: 30))),
    );
  }
}

class _SkillsWidget extends StatelessWidget {
  const _SkillsWidget({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 600,
      width: double.infinity,
      color: Colors.orange[100],
      child: const Center(child: Text('SKILLS', style: TextStyle(fontSize: 30))),
    );
  }
}

class _ContactWidget extends StatelessWidget {
  const _ContactWidget({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 500,
      width: double.infinity,
      color: Colors.purple[100],
      child: const Center(child: Text('CONTACT ME', style: TextStyle(fontSize: 30))),
    );
  }
}


