import 'package:flutter/material.dart';
import '../../../data/repositories/portfolio_data.dart';
import '../../../data/models/project_model.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/utils/responsive.dart';
import '../../../core/utils/url_helper.dart';
import '../common/glass_card.dart';
import '../common/sections_container.dart';

class ProjectsSection extends StatelessWidget {
  const ProjectsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final responsive = context.responsive;
    final projects = PortfolioData.projects;

    return SectionWithTitle(
      title: 'Featured Projects',
      subtitle: 'Production apps with active user bases',
      child: GridView.builder(
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
            tablet: 0.9,
            desktop: 1.0,
          ),
        ),
        itemCount: projects.length,
        itemBuilder: (context, index) {
          return _ProjectCard(project: projects[index]);
        },
      ),
    );
  }
}

class _ProjectCard extends StatelessWidget {
  final ProjectModel project;

  const _ProjectCard({
    Key? key,
    required this.project,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final responsive = context.responsive;

    return GlassCard(
      padding: EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Gradient Top Border
          Container(
            height: 4,
            decoration: BoxDecoration(
              gradient: project.gradient,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(AppConstants.radiusLg),
                topRight: Radius.circular(AppConstants.radiusLg),
              ),
            ),
          ),

          Padding(
            padding: EdgeInsets.all(
              responsive.getValue(
                mobile: AppConstants.spacingMd,
                tablet: AppConstants.spacingLg,
                desktop: AppConstants.spacingXl,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header with Links
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            project.title,
                            style: Theme.of(context)
                                .textTheme
                                .headlineMedium
                                ?.copyWith(
                              fontSize: responsive.getValue(
                                mobile: 20,
                                tablet: 22,
                                desktop: 24,
                              ),
                            ),
                          ),
                          const SizedBox(height: AppConstants.spacingXs),
                          Text(
                            project.subtitle,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                              color: AppColors.accentPurpleLight,
                            ),
                          ),
                          const SizedBox(height: AppConstants.spacingXs),
                          Text(
                            project.period,
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: AppConstants.spacingMd),
                    // Project Links
                    if (project.links.hasLinks)
                      _ProjectLinks(links: project.links),
                  ],
                ),

                const SizedBox(height: AppConstants.spacingLg),

                // Description
                Text(
                  project.description,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    height: 1.7,
                    fontSize: responsive.getValue(
                      mobile: 14,
                      tablet: 15,
                      desktop: 16,
                    ),
                  ),
                ),

                const SizedBox(height: AppConstants.spacingLg),

                // Technologies
                Wrap(
                  spacing: AppConstants.spacingSm,
                  runSpacing: AppConstants.spacingSm,
                  children: project.technologies.map((tech) {
                    return Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppConstants.spacingMd,
                        vertical: AppConstants.spacingSm,
                      ),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            AppColors.primaryPurple.withOpacity(0.2),
                            AppColors.primaryBlue.withOpacity(0.2),
                          ],
                        ),
                        borderRadius:
                        BorderRadius.circular(AppConstants.radiusFull),
                        border: Border.all(
                          color: AppColors.primaryPurple.withOpacity(0.3),
                          width: 1,
                        ),
                      ),
                      child: Text(
                        tech,
                        style: const TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w500,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ProjectLinks extends StatelessWidget {
  final ProjectLinks links;

  const _ProjectLinks({
    Key? key,
    required this.links,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final availableLinks = links.availableLinks;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: availableLinks.map((link) {
        return Padding(
          padding: const EdgeInsets.only(left: AppConstants.spacingXs),
          child: Tooltip(
            message: link.platform,
            child: InkWell(
              onTap: () => UrlHelper.launchURL(link.url),
              borderRadius: BorderRadius.circular(AppConstants.radiusSm),
              child: Container(
                padding: const EdgeInsets.all(AppConstants.spacingSm),
                decoration: BoxDecoration(
                  color: AppColors.glassBackground,
                  borderRadius: BorderRadius.circular(AppConstants.radiusSm),
                  border: Border.all(
                    color: AppColors.glassBorder,
                    width: 1,
                  ),
                ),
                child: Text(
                  link.icon,
                  style: const TextStyle(fontSize: 16),
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}





class ProjectsSection2 extends StatelessWidget {
  const ProjectsSection2({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      color: Colors.green.shade50,
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("My Projects", style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
          const SizedBox(height: 20),
          // Dynamic Grid: 1 column on mobile, 2 on desktop
          LayoutBuilder(builder: (context, constraints) {
            final crossAxisCount = constraints.maxWidth > 700 ? 2 : 1;
            return GridView.builder(
              shrinkWrap: true, // Vital for scrolling inside a Column
              physics: const NeverScrollableScrollPhysics(), // Disable internal scroll
              itemCount: 4,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 1.5,
              ),
              itemBuilder: (context, index) => Card(
                color: Colors.green.shade200,
                child: Center(child: Text("Project #${index + 1}")),
              ),
            );
          }),
        ],
      ),
    );
  }
}