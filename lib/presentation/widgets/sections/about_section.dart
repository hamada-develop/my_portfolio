import 'package:flutter/material.dart';

import '../../../core/constants/app_constants.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/utils/responsive.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    final responsive = context.responsive;
    return Column(
      children: [
        Text(
          'I\'m a ${AppConstants.title}.',
          style: AppTextStyles.h3.copyWith(
            fontSize: responsive.getValue(
              mobile: 24,
              tablet: 28,
              desktop: 32,
            ),
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(
          height: responsive.getValue(
            mobile: AppConstants.spacingMd,
            tablet: AppConstants.spacingLg,
            desktop: AppConstants.spacingXl,
          ),
        ),
        ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: responsive.getValue(
              mobile: double.infinity,
              tablet: 600,
              desktop: 800,
            ),
          ),
          child: Text(
            AppConstants.bio,
            style: AppTextStyles.bodyLarge.copyWith(
              fontSize: responsive.getValue(
                mobile: 14,
                tablet: 16,
                desktop: 18,
              ),
              height: 1.8,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
