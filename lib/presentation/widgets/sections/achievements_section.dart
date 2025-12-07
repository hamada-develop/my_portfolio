import 'package:flutter/material.dart';
import '../../../data/repositories/portfolio_data.dart';
import '../../../data/models/skill_model.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/utils/responsive.dart';
import '../common/gradient_text.dart';
import '../common/sections_container.dart';

class AchievementsSection extends StatelessWidget {
  const AchievementsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final responsive = context.responsive;
    final achievements = PortfolioData.achievements;

    return SectionContainer(
      child: Container(
        padding: EdgeInsets.all(
          responsive.getValue(
            mobile: AppConstants.spacingXl,
            tablet: AppConstants.spacingXxl,
            desktop: AppConstants.spacing3xl,
          ),
        ),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              AppColors.primaryPurple.withOpacity(0.2),
              AppColors.primaryBlue.withOpacity(0.2),
            ],
          ),
          borderRadius: BorderRadius.circular(AppConstants.radiusXl),
          border: Border.all(
            color: AppColors.glassBorder,
            width: 1,
          ),
        ),
        child: Column(
          children: [
            // Title
            GradientText(
              text: 'Key Achievements',
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

            // Achievement Grid
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: responsive.getValue(
                  mobile: 1,
                  tablet: 2,
                  desktop: 4,
                ),
                crossAxisSpacing: AppConstants.spacingLg,
                mainAxisSpacing: AppConstants.spacingLg,
                childAspectRatio: responsive.getValue(
                  mobile: 3.0,
                  tablet: 2.0,
                  desktop: 1.2,
                ),
              ),
              itemCount: achievements.length,
              itemBuilder: (context, index) {
                return _AchievementCard(achievement: achievements[index]);
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _AchievementCard extends StatelessWidget {
  final Achievement achievement;

  const _AchievementCard({
    Key? key,
    required this.achievement,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Value with gradient
        GradientText(
          text: achievement.value,
          gradient: const LinearGradient(
            colors: [
              AppColors.accentPurpleLight,
              AppColors.primaryPink,
            ],
          ),
          style: const TextStyle(
            fontSize: 56,
            fontWeight: FontWeight.bold,
            height: 1.0,
          ),
          textAlign: TextAlign.center,
        ),

        const SizedBox(height: AppConstants.spacingSm),

        // Title
        Text(
          achievement.title,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            fontWeight: FontWeight.w600,
          ),
          textAlign: TextAlign.center,
        ),

        const SizedBox(height: AppConstants.spacingXs),

        // Description
        Text(
          achievement.description,
          style: Theme.of(context).textTheme.bodySmall,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}