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


class WorkHistorySection2 extends StatelessWidget {
  const WorkHistorySection2({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      width: double.infinity,
      color: Colors.blueGrey.shade50, // Distinct background color
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Work History",
            style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 24),

          // List of Experience Cards
          _buildExperienceCard(
            context,
            company: "Tech Solutions Inc.",
            role: "Senior Flutter Developer",
            duration: "2023 - Present",
            description: "Led a team of 5 developers building a fintech super-app. Improved app performance by 40% using Isolates.",
          ),
          _buildExperienceCard(
            context,
            company: "Creative Studio",
            role: "Mobile App Developer",
            duration: "2021 - 2023",
            description: "Developed and shipped 3 e-commerce apps for high-profile clients. Integrated payment gateways and complex animations.",
          ),
          _buildExperienceCard(
            context,
            company: "Startup Hub",
            role: "Junior Android Developer",
            duration: "2018 - 2021",
            description: "Started with Native Android (Java/Kotlin) before migrating legacy codebases to Flutter.",
          ),
        ],
      ),
    );
  }

  Widget _buildExperienceCard(
      BuildContext context, {
        required String company,
        required String role,
        required String duration,
        required String description,
      }) {
    // Responsive Layout Check
    final isWide = MediaQuery.sizeOf(context).width > 600;

    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    company,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ),
                if (isWide) // Show duration on the right for desktop
                  Text(duration, style: const TextStyle(fontWeight: FontWeight.w500)),
              ],
            ),
            if (!isWide) ...[ // Show duration below title for mobile
              const SizedBox(height: 4),
              Text(duration, style: TextStyle(color: Colors.grey[600])),
            ],
            const SizedBox(height: 8),
            Text(
              role,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 12),
            Text(
              description,
              style: TextStyle(fontSize: 14, color: Colors.grey[800], height: 1.5),
            ),
          ],
        ),
      ),
    );
  }
}