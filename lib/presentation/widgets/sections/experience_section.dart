import 'package:flutter/material.dart';
import '../../../data/repositories/portfolio_data.dart';
import '../../../data/models/experience_model.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/utils/responsive.dart';
import '../common/glass_card.dart';
import '../common/sections_container.dart';

class ExperienceSection extends StatelessWidget {
  const ExperienceSection({super.key});

  @override
  Widget build(BuildContext context) {
    final experiences = PortfolioData.experiences;

    return SectionWithTitle(
      title: 'Work Experience',
      subtitle: 'My professional journey',
      child: Column(
        children: experiences.map((experience) {
          return Padding(
            padding: const EdgeInsets.only(bottom: AppConstants.spacingLg),
            child: _ExperienceCard(experience: experience),
          );
        }).toList(),
      ),
    );
  }
}

class _ExperienceCard extends StatelessWidget {
  final ExperienceModel experience;

  const _ExperienceCard({
    Key? key,
    required this.experience,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final responsive = context.responsive;

    return GlassCard(
      child: responsive.isMobile
          ? _buildMobileLayout(context)
          : _buildDesktopLayout(context),
    );
  }

  Widget _buildDesktopLayout(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Icon
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            gradient: AppColors.primaryGradient,
            borderRadius: BorderRadius.circular(AppConstants.radiusMd),
          ),
          child: Center(
            child: Text(
              experience.icon,
              style: const TextStyle(fontSize: 40),
            ),
          ),
        ),
        const SizedBox(width: AppConstants.spacingLg),

        // Content
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          experience.company,
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium
                              ?.copyWith(
                            color: AppColors.accentPurpleLight,
                            fontSize: 24,
                          ),
                        ),
                        const SizedBox(height: AppConstants.spacingXs),
                        Text(
                          experience.role,
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall
                              ?.copyWith(
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        experience.period,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      const SizedBox(height: AppConstants.spacingXs),
                      Text(
                        experience.location,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                ],
              ),

              const SizedBox(height: AppConstants.spacingLg),

              // Achievements
              ...experience.achievements.map((achievement) {
                return Padding(
                  padding: const EdgeInsets.only(
                    bottom: AppConstants.spacingSm,
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        '▹',
                        style: TextStyle(
                          color: AppColors.accentCyan,
                          fontSize: 20,
                        ),
                      ),
                      const SizedBox(width: AppConstants.spacingSm),
                      Expanded(
                        child: Text(
                          achievement,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(
                            height: 1.6,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildMobileLayout(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Icon and Header
        Row(
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                gradient: AppColors.primaryGradient,
                borderRadius: BorderRadius.circular(AppConstants.radiusMd),
              ),
              child: Center(
                child: Text(
                  experience.icon,
                  style: const TextStyle(fontSize: 30),
                ),
              ),
            ),
            const SizedBox(width: AppConstants.spacingMd),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    experience.company,
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      color: AppColors.accentPurpleLight,
                      fontSize: 18,
                    ),
                  ),
                  Text(
                    experience.role,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),

        const SizedBox(height: AppConstants.spacingMd),

        // Period and Location
        Text(
          '${experience.period} • ${experience.location}',
          style: Theme.of(context).textTheme.bodySmall,
        ),

        const SizedBox(height: AppConstants.spacingMd),

        // Achievements
        ...experience.achievements.map((achievement) {
          return Padding(
            padding: const EdgeInsets.only(bottom: AppConstants.spacingSm),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  '▹',
                  style: TextStyle(
                    color: AppColors.accentCyan,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(width: AppConstants.spacingSm),
                Expanded(
                  child: Text(
                    achievement,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontSize: 14,
                      height: 1.6,
                    ),
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ],
    );
  }
}