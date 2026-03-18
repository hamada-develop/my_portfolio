import 'dart:async';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../data/repositories/portfolio_data.dart';
import '../../../data/models/project_model.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/utils/responsive.dart';
import '../common/gradient_text.dart';
import '../common/sections_container.dart';
import '../common/glass_card.dart';
import '../../../core/widgets/scroll_animate_in.dart';

class ProjectsSection extends StatelessWidget {
  const ProjectsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final responsive = context.responsive;
    final projects = PortfolioData.projects;

    return Column(
      children: [
        SectionContainer(
          useMinHeight: false,
          child: Column(
            children: [
              // Title
              ScrollAnimateIn(
                child: GradientText(
                  text: AppConstants.sectionTitleProjects,
                  gradient: AppColors.textGradient,
                  style: Theme.of(context).textTheme.displaySmall?.copyWith(
                    fontSize: responsive.getValue(
                      mobile: 28,
                      tablet: 32,
                      desktop: 36,
                    ),
                  ),
                  textAlign: TextAlign.center,
                ),
              ),

              SizedBox(
                height: responsive.getValue(
                  mobile: AppConstants.spacingXl,
                  tablet: AppConstants.spacingXxl,
                  desktop: AppConstants.spacing3xl,
                ),
              ),
            ],
          ),
        ),

        // Projects Slider outside SectionContainer for full width
        _ProjectsSlider(projects: projects),

        // Add bottom padding to account for the removed SectionContainer's min height
        SizedBox(
          height: responsive.getValue(mobile: 40, tablet: 80, desktop: 120),
        ),
      ],
    );
  }
}

class _ProjectsSlider extends StatefulWidget {
  final List<ProjectModel> projects;

  const _ProjectsSlider({required this.projects});

  @override
  State<_ProjectsSlider> createState() => _ProjectsSliderState();
}

class _ProjectsSliderState extends State<_ProjectsSlider> {
  late PageController _pageController;
  int _currentPage = 0;
  double _currentViewportFraction = 0.85;
  static const int _loopScale = 1000;
  Timer? _autoScrollTimer;

  @override
  void initState() {
    super.initState();
    _currentPage = widget.projects.isEmpty
        ? 0
        : (widget.projects.length * (_loopScale ~/ 2));
    _pageController = PageController(
      viewportFraction: _currentViewportFraction,
      initialPage: _currentPage,
    );
    _startAutoScroll();
  }

  void _startAutoScroll() {
    _autoScrollTimer?.cancel();
    _autoScrollTimer = Timer.periodic(const Duration(seconds: 4), (timer) {
      if (_pageController.hasClients) {
        _pageController.nextPage(
          duration: const Duration(milliseconds: 1000),
          curve: Curves.easeInOutCubic,
        );
      }
    });
  }

  void _stopAutoScroll() {
    _autoScrollTimer?.cancel();
    _autoScrollTimer = null;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final responsive = context.responsive;
    final newViewportFraction = responsive.getValue<double>(
      mobile: 0.85,
      tablet: 0.6,
      desktop: 0.4,
    );

    if (newViewportFraction != _currentViewportFraction) {
      _currentViewportFraction = newViewportFraction;
      _pageController.dispose();
      _pageController = PageController(
        viewportFraction: _currentViewportFraction,
        initialPage: _currentPage,
      );
    }
  }

  @override
  void dispose() {
    _stopAutoScroll();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.projects.isEmpty) return const SizedBox();

    final responsive = context.responsive;
    final double height = responsive.getValue(
      mobile: 540,
      tablet: 600,
      desktop: 650,
    );

    return Column(
      children: [
        SizedBox(
          height: height,
          child: MouseRegion(
            onEnter: (_) => _stopAutoScroll(),
            onExit: (_) => _startAutoScroll(),
            child: Listener(
              onPointerDown: (_) => _stopAutoScroll(),
              onPointerUp: (_) => _startAutoScroll(),
              onPointerSignal: (pointerSignal) {
                if (pointerSignal is PointerScrollEvent) {
                  // Manual pass-through for vertical scrolling on trackpads
                  if (pointerSignal.scrollDelta.dy.abs() >
                      pointerSignal.scrollDelta.dx.abs()) {
                    final scrollable = Scrollable.of(context);
                    scrollable.position.jumpTo(
                      scrollable.position.pixels + pointerSignal.scrollDelta.dy,
                    );
                  }
                }
              },
              child: ScrollConfiguration(
                behavior: ScrollConfiguration.of(context).copyWith(
                  dragDevices: {
                    PointerDeviceKind.mouse,
                    PointerDeviceKind.trackpad,
                    PointerDeviceKind.touch,
                  },
                ),
                child: PageView.builder(
                  controller: _pageController,
                  physics: const BouncingScrollPhysics(),
                  allowImplicitScrolling: true,
                  onPageChanged: (index) {
                    setState(() {
                      _currentPage = index;
                    });
                  },
                  itemCount: widget.projects.length * _loopScale,
                  itemBuilder: (context, index) {
                    final projectIndex = index % widget.projects.length;
                    return AnimatedBuilder(
                      animation: _pageController,
                      builder: (context, child) {
                        double scale = 1.0;
                        double opacity = 1.0;
                        if (_pageController.position.haveDimensions) {
                          double pageDiff = (_pageController.page! - index).abs();
                          scale = (1 - (pageDiff * 0.2)).clamp(0.0, 1.0);
                          opacity = (1 - (pageDiff * 0.4)).clamp(0.3, 1.0);
                        } else {
                          scale = _currentPage == index ? 1.0 : 0.8;
                          opacity = _currentPage == index ? 1.0 : 0.6;
                        }

                        return Transform.scale(
                          scale: Curves.easeOut.transform(scale),
                          child: Opacity(
                            opacity: opacity,
                            child: child,
                          ),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppConstants.spacingSm,
                          vertical: AppConstants.spacingMd,
                        ),
                        child: _ProjectCard(
                          project: widget.projects[projectIndex],
                          index: index,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: AppConstants.spacingLg),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(widget.projects.length, (index) {
            final isSelected = (_currentPage % widget.projects.length) == index;
            return AnimatedContainer(
              duration: AppConstants.animationNormal,
              margin: const EdgeInsets.symmetric(horizontal: 4),
              height: 8,
              width: isSelected ? 24 : 8,
              decoration: BoxDecoration(
                color: isSelected
                    ? AppColors.primaryBlue
                    : AppColors.glassBorder,
                borderRadius: BorderRadius.circular(4),
              ),
            );
          }),
        ),
      ],
    );
  }
}

class _ProjectCard extends StatelessWidget {
  final ProjectModel project;
  final int index;

  const _ProjectCard({required this.project, required this.index});

  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  @override
  Widget build(BuildContext context) {
    final responsive = context.responsive;
    final isLight = Theme.of(context).brightness == Brightness.light;
    final buttonBg = isLight ? Colors.black.withValues(alpha: 0.05) : Colors.white.withValues(alpha: 0.1);

    return GlassCard(
          width: double.infinity,
          padding: EdgeInsets.zero,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Project Gradient Header / Image Placeholder
              Container(
                height: responsive.getValue(
                  mobile: 220,
                  tablet: 260,
                  desktop: 380,
                ),
                decoration: BoxDecoration(
                  gradient: project.gradient,
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(AppConstants.radiusLg),
                  ),
                ),
                child: Stack(
                  children: [
                    if (project.image != null)
                      Positioned.fill(
                        child: ClipRRect(
                          borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(AppConstants.radiusLg),
                          ),
                          child: Image.asset(
                            project.image!,
                            fit: BoxFit.cover,
                            frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
                              if (wasSynchronouslyLoaded) return child;
                              return AnimatedOpacity(
                                opacity: frame == null ? 0 : 1,
                                duration: const Duration(milliseconds: 500),
                                curve: Curves.easeOut,
                                child: child,
                              );
                            },
                          ),
                        ),
                      )
                    else
                      Center(
                        child: Text(
                          project.title[0],
                          style: const TextStyle(
                            fontSize: 64,
                            fontWeight: FontWeight.bold,
                            color: Colors.white24,
                          ),
                        ),
                      ),
                    Positioned(
                      bottom: AppConstants.spacingMd,
                      left: AppConstants.spacingMd,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.black26,
                          borderRadius: BorderRadius.circular(
                            AppConstants.radiusFull,
                          ),
                        ),
                        child: Text(
                          project.period,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Content
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(AppConstants.spacingSm),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        project.title,
                        style: Theme.of(context).textTheme.headlineSmall
                            ?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                      ),
                      const SizedBox(height: AppConstants.spacingXs),
                      Text(
                        project.subtitle,
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          color: AppColors.primaryBlue,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: AppConstants.spacingSm),
                      Expanded(
                        child: Text(
                          project.description,
                          style: Theme.of(context).textTheme.bodyMedium
                              ?.copyWith(
                                color: context.adaptiveTextSecondary,
                                height: 1.5,
                              ),
                          maxLines: 4,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(height: AppConstants.spacingSm),

                      // Technologies
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: project.technologies.take(4).map((tech) {
                          return Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: Theme.of(context)
                                  .colorScheme
                                  .surfaceContainerHigh
                                  .withValues(alpha: 0.3),
                              borderRadius: BorderRadius.circular(
                                AppConstants.radiusSm,
                              ),
                              border: Border.all(
                                color: AppColors.glassBorder.withValues(
                                  alpha: 0.5,
                                ),
                              ),
                            ),
                            child: Text(
                              tech,
                              style: Theme.of(context).textTheme.bodySmall
                                  ?.copyWith(
                                    color: context.adaptiveTextSecondary,
                                    fontSize: 11,
                                  ),
                            ),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),
              ),

              // Actions
              Padding(
                padding: const EdgeInsets.fromLTRB(
                  AppConstants.spacingLg,
                  0,
                  AppConstants.spacingLg,
                  AppConstants.spacingSm,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    if (project.links.appStore != null)
                      IconButton(
                        onPressed: () => _launchUrl(project.links.appStore!),
                        icon: const Icon(Icons.apple),
                        tooltip: AppConstants.tooltipAppStore,
                        style: IconButton.styleFrom(
                          backgroundColor: buttonBg,
                        ),
                      ),
                    const SizedBox(width: 8),
                    if (project.links.playStore != null)
                      IconButton(
                        onPressed: () => _launchUrl(project.links.playStore!),
                        icon: const Icon(Icons.android),
                        tooltip: AppConstants.tooltipPlayStore,
                        style: IconButton.styleFrom(
                          backgroundColor: buttonBg,
                        ),
                      ),
                    const SizedBox(width: 8),
                    if (project.links.web != null)
                      IconButton(
                        onPressed: () => _launchUrl(project.links.web!),
                        icon: const Icon(Icons.language),
                        tooltip: AppConstants.tooltipWebsite,
                        style: IconButton.styleFrom(
                          backgroundColor: buttonBg,
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        );
  }
}
