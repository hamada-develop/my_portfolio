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
import 'package:flutter_animate/flutter_animate.dart';

class ProjectsSection extends StatelessWidget {
  const ProjectsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final responsive = context.responsive;
    final projects = PortfolioData.projects;

    return SectionContainer(
      child: Column(
        children: [
          // Title
          GradientText(
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

          SizedBox(
            height: responsive.getValue(
              mobile: AppConstants.spacingXl,
              tablet: AppConstants.spacingXxl,
              desktop: AppConstants.spacing3xl,
            ),
          ),

          // Projects Grid
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: responsive.getValue(
                mobile: 1,
                tablet: 2,
                desktop: 2,
              ),
              crossAxisSpacing: AppConstants.spacingLg,
              mainAxisSpacing: AppConstants.spacingLg,
              childAspectRatio: responsive.getValue(
                mobile: 0.85,
                tablet: 0.75,
                desktop: 1.1,
              ),
            ),
            itemCount: projects.length,
            itemBuilder: (context, index) {
              return _ProjectCard(project: projects[index], index: index);
            },
          ),
        ],
      ),
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

    return GlassCard(
          width: double.infinity,
          padding: EdgeInsets.zero,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Project Gradient Header / Image Placeholder
              Container(
                height: responsive.getValue(
                  mobile: 140,
                  tablet: 160,
                  desktop: 180,
                ),
                decoration: BoxDecoration(
                  gradient: project.gradient,
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(AppConstants.radiusLg),
                  ),
                ),
                child: Stack(
                  children: [
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
                  padding: const EdgeInsets.all(AppConstants.spacingLg),
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
                      const SizedBox(height: 4),
                      Text(
                        project.subtitle,
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          color: AppColors.primaryBlue,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: AppConstants.spacingMd),
                      Expanded(
                        child: Text(
                          project.description,
                          style: Theme.of(context).textTheme.bodyMedium
                              ?.copyWith(
                                color: AppColors.textSecondary,
                                height: 1.5,
                              ),
                          maxLines: 4,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(height: AppConstants.spacingMd),

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
                                color: AppColors.glassBorder.withValues(alpha: 0.5),
                              ),
                            ),
                            child: Text(
                              tech,
                              style: Theme.of(context).textTheme.bodySmall
                                  ?.copyWith(
                                    color: AppColors.textSecondary,
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
                  AppConstants.spacingLg,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    if (project.links.appStore != null)
                      IconButton(
                        onPressed: () => _launchUrl(project.links.appStore!),
                        icon: const Icon(Icons.apple),
                        tooltip: 'App Store',
                        style: IconButton.styleFrom(
                          backgroundColor: Colors.white.withValues(alpha: 0.1),
                        ),
                      ),
                    const SizedBox(width: 8),
                    if (project.links.playStore != null)
                      IconButton(
                        onPressed: () => _launchUrl(project.links.playStore!),
                        icon: const Icon(Icons.android),
                        tooltip: 'Play Store',
                        style: IconButton.styleFrom(
                          backgroundColor: Colors.white.withValues(alpha: 0.1),
                        ),
                      ),
                    const SizedBox(width: 8),
                    if (project.links.web != null)
                      IconButton(
                        onPressed: () => _launchUrl(project.links.web!),
                        icon: const Icon(Icons.language),
                        tooltip: 'Website',
                        style: IconButton.styleFrom(
                          backgroundColor: Colors.white.withValues(alpha: 0.1),
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        )
        .animate()
        .fadeIn(duration: 600.ms, delay: (100 * index).ms)
        .scale(
          begin: const Offset(0.95, 0.95),
          duration: 600.ms,
          delay: (100 * index).ms,
        );
  }
}
