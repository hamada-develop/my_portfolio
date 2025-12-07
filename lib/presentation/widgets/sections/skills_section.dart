import 'package:flutter/material.dart';
import '../../../data/repositories/portfolio_data.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/utils/responsive.dart';
import '../common/glass_card.dart';
import '../common/custom_button.dart';
import '../common/sections_container.dart';

class SkillsSection extends StatelessWidget {
  const SkillsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final responsive = context.responsive;
    final skills = PortfolioData.skills;

    return SectionWithTitle(
      title: 'Technical Expertise',
      subtitle: 'Technologies and tools I work with',
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: responsive.getValue(
            mobile: 1,
            tablet: 2,
            desktop: 3,
          ),
          crossAxisSpacing: AppConstants.spacingLg,
          mainAxisSpacing: AppConstants.spacingLg,
          childAspectRatio: responsive.getValue(
            mobile: 2.5,
            tablet: 2.0,
            desktop: 1.8,
          ),
        ),
        itemCount: skills.length,
        itemBuilder: (context, index) {
          final skillCategory = skills[index];
          return _SkillCard(
            category: skillCategory.category,
            icon: skillCategory.icon,
            skills: skillCategory.skills,
          );
        },
      ),
    );
  }
}

class _SkillCard extends StatelessWidget {
  final String category;
  final String? icon;
  final List<String> skills;

  const _SkillCard({
    Key? key,
    required this.category,
    this.icon,
    required this.skills,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Category Title with Icon
          Row(
            children: [
              if (icon != null) ...[
                Text(
                  icon!,
                  style: const TextStyle(fontSize: 24),
                ),
                const SizedBox(width: AppConstants.spacingSm),
              ],
              Expanded(
                child: Text(
                  category,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: const Color(0xFFA78BFA),
                    fontSize: 20,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppConstants.spacingLg),

          // Skills
          Expanded(
            child: Wrap(
              spacing: AppConstants.spacingSm,
              runSpacing: AppConstants.spacingSm,
              children: skills.map((skill) {
                return ChipButton(
                  label: skill,
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}