import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/animations.dart';
import '../../../../core/widgets/animated_floating_action_button.dart';
import '../../../../core/widgets/disappearing_navigation_bottom.dart';
import '../../../../core/widgets/disappearing_navigation_rail.dart';
import '../controller/home_cubit.dart';
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
    _homeCubit = context.read<HomeCubit>();
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
    if (width >= 600) {
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
    return BlocListener<HomeCubit, HomeState>(
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
            Expanded(child: HomeContent(colorScheme: colorScheme)),
          ],
        ),
        bottomNavigationBar: DisappearingNavigationBottom(
          // Make sure to select the current index from state if your widget supports it,
          // otherwise just the callback:
          selectedIndex: context.select(
            (HomeCubit cubit) => cubit.state.destination,
          ),
          onDestinationSelected: (index) {
            _homeCubit.changeDestination(index);
          },
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
  late final ScrollController _scrollController;
  final _sectionKeys = List.generate(5, (index) => GlobalKey());

  // Flag to prevent the scroll-spy from firing while we are animating to a section
  bool _isAutoScrolling = false;

  // Flag to prevent the BlocListener from forcing a scroll when WE caused the state change manually
  bool _isManuallyScrollingDetect = false;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    // 1. If we are auto-scrolling (animation), don't try to detect sections
    if (_isAutoScrolling) return;

    final threshold = MediaQuery.sizeOf(context).height * 0.4; // 40% of screen
    final cubit = context.read<HomeCubit>();

    double? getY(GlobalKey key) {
      final RenderBox? box =
          key.currentContext?.findRenderObject() as RenderBox?;
      // If widget is not rendered, return null
      return box?.localToGlobal(Offset.zero).dy;
    }

    int newIndex = cubit.state.destination;

    // Iterate backwards to find the first section that has crossed the threshold
    for (int i = 4; i >= 0; i--) {
      final y = getY(_sectionKeys[i]);
      if (y != null && y <= threshold) {
        newIndex = i;
        break;
      }
    }

    if (newIndex != cubit.state.destination) {
      // 2. Mark that this change is coming from a manual scroll
      _isManuallyScrollingDetect = true;
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
        // 3. Changed alignment to 0.0 (top) so the section snaps to the top of the screen
        alignment: 0.0,
      );
      // Small delay to ensure physics have settled
      await Future.delayed(const Duration(milliseconds: 100));
      _isAutoScrolling = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<HomeCubit, HomeState>(
      listenWhen: (previous, current) =>
          previous.destination != current.destination,
      listener: (context, state) {
        // 4. THE FIX: If this state change was caused by manual scrolling, ignore it.
        if (_isManuallyScrollingDetect) {
          _isManuallyScrollingDetect = false;
          return;
        }

        if (_scrollController.hasClients && !_isAutoScrolling) {
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
          child: CustomScrollView(
            controller: _scrollController,
            slivers: [
              // Ensure these widgets actually assign the key to their root RenderObject!
              SliverToBoxAdapter(child: AboutSection(key: _sectionKeys[0])),
              SliverToBoxAdapter(child: ProjectsSection(key: _sectionKeys[1])),
              SliverToBoxAdapter(
                child: WorkHistorySection(key: _sectionKeys[2]),
              ),
              SliverToBoxAdapter(child: SkillsSection(key: _sectionKeys[3])),
              SliverToBoxAdapter(child: ContactSection(key: _sectionKeys[4])),
            ],
          ),
        ),
      ),
    );
  }
}
