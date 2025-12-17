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




class AboutSection2 extends StatelessWidget {
  const AboutSection2({super.key});

  @override
  Widget build(BuildContext context) {
    // Calculates one full screen height
    final screenHeight = MediaQuery.sizeOf(context).height;

    return Container(
      // Ensure it takes at least the full screen height
      constraints: BoxConstraints(minHeight: screenHeight),
      alignment: Alignment.center,
      color: Colors.red.shade50, // Light red background
      padding: const EdgeInsets.all(24),
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(radius: 80, backgroundColor: Colors.red),
          SizedBox(height: 20),
          Text("Hello, I'm Hamada", style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold)),
          Text("Senior Flutter Developer", style: TextStyle(fontSize: 24)),
        ],
      ),
    );
  }
}