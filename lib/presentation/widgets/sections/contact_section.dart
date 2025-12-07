import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/utils/responsive.dart';
import '../../../core/utils/url_helper.dart';
import '../common/custom_button.dart';
import '../common/sections_container.dart';

class ContactSection extends StatelessWidget {
  const ContactSection({super.key});

  @override
  Widget build(BuildContext context) {
    final responsive = context.responsive;

    return SectionContainer(
      padding: EdgeInsets.symmetric(
        horizontal: responsive.getValue(
          mobile: AppConstants.spacingMd,
          tablet: AppConstants.spacingXl,
          desktop: AppConstants.spacing3xl,
        ),
        vertical: responsive.getValue(
          mobile: AppConstants.spacingXxl,
          tablet: AppConstants.spacing3xl,
          desktop: AppConstants.spacing4xl,
        ),
      ),
      child: Column(
        children: [
          // Title
          Text(
            'Contact',
            style: Theme.of(context).textTheme.displayMedium?.copyWith(
              fontSize: responsive.getValue(
                mobile: 32,
                tablet: 40,
                desktop: 48,
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

          // Description
          ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: responsive.getValue(
                mobile: double.infinity,
                tablet: 600,
                desktop: 800,
              ),
            ),
            child: Text(
              'I\'m currently looking to join a cross-functional team that values '
                  'improving people\'s lives through accessible design. Let\'s connect!',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                fontSize: responsive.getValue(
                  mobile: 16,
                  tablet: 17,
                  desktop: 18,
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

          // Social Links
          Wrap(
            spacing: AppConstants.spacingLg,
            runSpacing: AppConstants.spacingLg,
            alignment: WrapAlignment.center,
            children: [
              SocialIconButton(
                icon: Icons.email,
                tooltip: 'Email',
                onPressed: () => UrlHelper.launchEmail(AppConstants.email),
              ),
              SocialIconButton(
                icon: Icons.link,
                tooltip: 'LinkedIn',
                onPressed: () => UrlHelper.launchURL(AppConstants.linkedInUrl),
              ),
              SocialIconButton(
                icon: Icons.code,
                tooltip: 'GitHub',
                onPressed: () => UrlHelper.launchURL(AppConstants.githubUrl),
              ),
              SocialIconButton(
                icon: Icons.phone,
                tooltip: 'Phone',
                onPressed: () => UrlHelper.launchPhone(AppConstants.phone),
              ),
            ],
          ),

          SizedBox(
            height: responsive.getValue(
              mobile: AppConstants.spacingXl,
              tablet: AppConstants.spacingXxl,
              desktop: AppConstants.spacing3xl,
            ),
          ),

          // Contact Details
          Column(
            children: [
              Text(
                AppConstants.email,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: AppColors.textTertiary,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppConstants.spacingSm),
              Text(
                AppConstants.phone,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: AppColors.textTertiary,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppConstants.spacingMd),
              Text(
                '${AppConstants.location} • ${AppConstants.availability}',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.textTertiary,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// Footer
class FooterSection extends StatelessWidget {
  const FooterSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: AppConstants.spacingXl,
      ),
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(
            color: AppColors.glassBorder,
            width: 1,
          ),
        ),
      ),
      child: Center(
        child: Text(
          '© 2025 ${AppConstants.name}. Built with Flutter.',
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: AppColors.textMuted,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}