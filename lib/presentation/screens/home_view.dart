import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_banners/super_banners.dart';
import 'package:url_launcher/url_launcher.dart';

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
import '../../../../core/constants/app_constants.dart';

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
      precacheImage(AssetImage(AppConstants.avatarPrimary), context);
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
        final width = MediaQuery.sizeOf(context).width;
        _animateRailBasedOnWidth(width);
      },
      child: Scaffold(
        backgroundColor: colorScheme.surfaceBright,
        body: Stack(
          children: [
            Row(
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
            PositionedDirectional(
              end: 0,
              child: CornerBanner(
                bannerPosition: CornerBannerPosition.topRight,
                bannerColor: Colors.red,
                child: Text(AppConstants.bannerUnderDevelopment),
              ),
            ),
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
                  onPressed: () async {
                    final url = Uri.parse(AppConstants.resumeUrl);
                    if (await canLaunchUrl(url)) {
                      await launchUrl(url);
                    }
                  },
                  icon: Icons.description_rounded,
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
  late final FocusNode _focusNode;
  final _sectionKeys = List.generate(5, (index) => GlobalKey());

  // Flag to prevent the scroll-spy from firing while we are animating to a section
  bool _isAutoScrolling = false;

  // Set to track destination changes initiated by user scrolling
  final Set<int> _manualScrollDestinations = {};

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
    _focusNode = FocusNode();
    // Auto-focus the content area for keyboard navigation
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _focusNode.requestFocus();
    });
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _onScroll() {
    // 1. If we are auto-scrolling (animation), don't try to detect sections
    if (_isAutoScrolling) return;

    final cubit = context.read<HomeCubit>();
    final screenHeight = MediaQuery.sizeOf(context).height;

    // 2. Check if scrolled to bottom - select last section (Contact)
    if (_scrollController.hasClients) {
      final maxScroll = _scrollController.position.maxScrollExtent;
      final currentScroll = _scrollController.position.pixels;
      // If within 50 pixels of bottom, select last section
      if (maxScroll - currentScroll < 50) {
        if (cubit.state.destination != 4) {
          _manualScrollDestinations.add(4);
          cubit.changeDestination(4);
        }
        return;
      }
    }

    // 3. Use 25% threshold for earlier, more natural detection
    final threshold = screenHeight * 0.25;

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
      // 4. Mark that this change is coming from a manual scroll
      _manualScrollDestinations.add(newIndex);
      cubit.changeDestination(newIndex);
    }
  }


  @override
  Widget build(BuildContext context) {
    final cubit = context.read<HomeCubit>();
    final isMobile = MediaQuery.sizeOf(context).width < 600;

    return Shortcuts(
      shortcuts: <ShortcutActivator, Intent>{
        const SingleActivator(LogicalKeyboardKey.arrowDown):
            const _NavigateIntent(1),
        const SingleActivator(LogicalKeyboardKey.arrowUp):
            const _NavigateIntent(-1),
        const SingleActivator(LogicalKeyboardKey.home):
            const _NavigateToIndexIntent(0),
        const SingleActivator(LogicalKeyboardKey.end):
            const _NavigateToIndexIntent(4),
        const SingleActivator(LogicalKeyboardKey.digit1):
            const _NavigateToIndexIntent(0),
        const SingleActivator(LogicalKeyboardKey.digit2):
            const _NavigateToIndexIntent(1),
        const SingleActivator(LogicalKeyboardKey.digit3):
            const _NavigateToIndexIntent(2),
        const SingleActivator(LogicalKeyboardKey.digit4):
            const _NavigateToIndexIntent(3),
        const SingleActivator(LogicalKeyboardKey.digit5):
            const _NavigateToIndexIntent(4),
      },
      child: Actions(
        actions: <Type, Action<Intent>>{
          _NavigateIntent: CallbackAction<_NavigateIntent>(
            onInvoke: (intent) {
              final current = cubit.state.destination;
              final next = (current + intent.delta).clamp(0, 4);
              if (next != current) cubit.changeDestination(next);
              return null;
            },
          ),
          _NavigateToIndexIntent: CallbackAction<_NavigateToIndexIntent>(
            onInvoke: (intent) {
              cubit.changeDestination(intent.index);
              return null;
            },
          ),
        },
        child: Focus(
          focusNode: _focusNode,
          child: isMobile
              ? _MobileContent(colorScheme: widget.colorScheme)
              : _DesktopContent(
                  colorScheme: widget.colorScheme,
                  scrollController: _scrollController,
                  sectionKeys: _sectionKeys,
                  manualScrollDestinations: _manualScrollDestinations,
                ),
        ),
      ),
    );
  }
}

/// Mobile layout: shows one section at a time with animated transitions.
class _MobileContent extends StatelessWidget {
  final ColorScheme colorScheme;

  const _MobileContent({required this.colorScheme});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<HomeCubit, HomeState, int>(
      selector: (state) => state.destination,
      builder: (context, destination) {
        final sections = <Widget>[
          const AboutSection(),
          const ProjectsSection(),
          const WorkHistorySection(),
          const SkillsSection(),
          const ContactSection(),
        ];

        return Container(
          margin: const EdgeInsets.only(top: 8, left: 8, right: 8, bottom: 8),
          decoration: BoxDecoration(
            color: colorScheme.surface,
            borderRadius: const BorderRadius.all(Radius.circular(20)),
          ),
          child: ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(20)),
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 350),
              switchInCurve: Curves.easeOut,
              switchOutCurve: Curves.easeIn,
              transitionBuilder: (child, animation) {
                return FadeTransition(
                  opacity: animation,
                  child: SlideTransition(
                    position: Tween<Offset>(
                      begin: const Offset(0.05, 0),
                      end: Offset.zero,
                    ).animate(animation),
                    child: child,
                  ),
                );
              },
              child: SingleChildScrollView(
                key: ValueKey<int>(destination),
                child: RepaintBoundary(
                  child: sections[destination],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

/// Desktop layout: all sections in a single scrollable view with scroll-spy.
class _DesktopContent extends StatelessWidget {
  final ColorScheme colorScheme;
  final ScrollController scrollController;
  final List<GlobalKey> sectionKeys;
  final Set<int> manualScrollDestinations;

  const _DesktopContent({
    required this.colorScheme,
    required this.scrollController,
    required this.sectionKeys,
    required this.manualScrollDestinations,
  });

  Future<void> _scrollToSection(int index) async {
    final context = sectionKeys[index].currentContext;
    if (context != null) {
      await Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeInOut,
        alignment: 0.0,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<HomeCubit, HomeState>(
      listenWhen: (previous, current) =>
          previous.destination != current.destination,
      listener: (context, state) {
        if (manualScrollDestinations.remove(state.destination)) {
          return;
        }
        if (scrollController.hasClients) {
          _scrollToSection(state.destination);
        }
      },
      child: Container(
        margin: const EdgeInsets.only(top: 24, left: 16, right: 16),
        decoration: BoxDecoration(
          color: colorScheme.surface,
          borderRadius: const BorderRadius.all(Radius.circular(20)),
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          child: CustomScrollView(
            controller: scrollController,
            slivers: [
              SliverToBoxAdapter(
                child: RepaintBoundary(
                  child: AboutSection(key: sectionKeys[0]),
                ),
              ),
              SliverToBoxAdapter(
                child: RepaintBoundary(
                  child: ProjectsSection(key: sectionKeys[1]),
                ),
              ),
              SliverToBoxAdapter(
                child: RepaintBoundary(
                  child: WorkHistorySection(key: sectionKeys[2]),
                ),
              ),
              SliverToBoxAdapter(
                child: RepaintBoundary(
                  child: SkillsSection(key: sectionKeys[3]),
                ),
              ),
              SliverToBoxAdapter(
                child: RepaintBoundary(
                  child: ContactSection(key: sectionKeys[4]),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Intent for relative navigation (up/down by delta).
class _NavigateIntent extends Intent {
  final int delta;
  const _NavigateIntent(this.delta);
}

/// Intent for direct navigation to a specific section index.
class _NavigateToIndexIntent extends Intent {
  final int index;
  const _NavigateToIndexIntent(this.index);
}
