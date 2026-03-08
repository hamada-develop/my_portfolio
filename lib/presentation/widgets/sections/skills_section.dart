import 'package:flutter/material.dart';
import '../../../data/repositories/portfolio_data.dart';
import '../../../data/models/skill_model.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/utils/responsive.dart';
import '../common/gradient_text.dart';
import '../common/sections_container.dart';
import '../common/glass_card.dart';
import 'package:flutter_animate/flutter_animate.dart';

class SkillsSection extends StatelessWidget {
  const SkillsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final responsive = context.responsive;
    final skills = PortfolioData.skills;

    return SectionContainer(
      child: Column(
        children: [
          // Title
          GradientText(
            text: AppConstants.sectionTitleSkills,
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

          // Skills Grid
          LayoutBuilder(
            builder: (context, constraints) {
              return Wrap(
                spacing: AppConstants.spacingLg,
                runSpacing: AppConstants.spacingLg,
                alignment: WrapAlignment.center,
                children: skills.asMap().entries.map((entry) {
                  final index = entry.key;
                  final category = entry.value;
                  return _SkillCategoryCard(category: category, index: index);
                }).toList(),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _SkillCategoryCard extends StatelessWidget {
  final SkillCategory category;
  final int index;

  const _SkillCategoryCard({required this.category, required this.index});

  @override
  Widget build(BuildContext context) {
    final responsive = context.responsive;

    return GlassCard(
          width: responsive.getValue(
            mobile: double.infinity,
            tablet: 340,
            desktop: 380,
          ),
          padding: const EdgeInsets.all(AppConstants.spacingLg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: AppColors.primaryPurple.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(
                        AppConstants.radiusMd,
                      ),
                    ),
                    child: Text(
                      category.icon ?? '',
                      style: const TextStyle(fontSize: 24),
                    ),
                  ),
                  const SizedBox(width: AppConstants.spacingMd),
                  Expanded(
                    child: Text(
                      category.category,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: AppConstants.spacingLg),

              // Skills Chips
              Wrap(
                spacing: AppConstants.spacingSm,
                runSpacing: AppConstants.spacingSm,
                children: category.skills.map((skill) {
                  return Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: Theme.of(
                        context,
                      ).colorScheme.surfaceContainerHigh.withValues(alpha: 0.5),
                      borderRadius: BorderRadius.circular(
                        AppConstants.radiusFull,
                      ),
                      border: Border.all(
                        color: AppColors.glassBorder,
                        width: 1,
                      ),
                    ),
                    child: Text(
                      skill,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        )
        .animate()
        .fadeIn(duration: 600.ms, delay: (100 * index).ms)
        .slideY(begin: 0.2, end: 0, duration: 600.ms, delay: (100 * index).ms);
  }
}
