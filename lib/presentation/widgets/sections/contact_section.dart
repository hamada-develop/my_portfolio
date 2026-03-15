import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/utils/responsive.dart';
import '../common/gradient_text.dart';
import '../common/sections_container.dart';
import '../common/glass_card.dart';
import '../../../core/widgets/scroll_animate_in.dart';

class ContactSection extends StatelessWidget {
  const ContactSection({super.key});

  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  @override
  Widget build(BuildContext context) {
    final responsive = context.responsive;

    return SectionContainer(
      useMinHeight: false,
      child: Column(
        children: [
          // Title
          ScrollAnimateIn(
            child: GradientText(
              text: AppConstants.sectionTitleContact,
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
          ),

          SizedBox(
            height: responsive.getValue(
              mobile: AppConstants.spacingXl,
              tablet: AppConstants.spacingXxl,
              desktop: AppConstants.spacing3xl,
            ),
          ),

          ScrollAnimateIn(
            delay: const Duration(milliseconds: 200),
            child: GlassCard(
                width: double.infinity,
                padding: EdgeInsets.all(
                  responsive.getValue(
                    mobile: AppConstants.spacingLg,
                    tablet: AppConstants.spacingXl,
                    desktop: AppConstants.spacingXxl,
                  ),
                ),
                child: Column(
                  children: [
                    Text(
                      AppConstants.contactMessage,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: AppColors.textSecondary,
                        height: 1.6,
                        fontSize: responsive.getValue(
                          mobile: 16,
                          tablet: 18,
                          desktop: 20,
                        ),
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: AppConstants.spacingXl),

                    // Contact Details
                    Wrap(
                      spacing: AppConstants.spacingXl,
                      runSpacing: AppConstants.spacingLg,
                      alignment: WrapAlignment.center,
                      children: [
                        _ContactItem(
                          icon: Icons.email_outlined,
                          label: AppConstants.contactEmailLabel,
                          value: AppConstants.email,
                          onTap: () =>
                              _launchUrl('mailto:${AppConstants.email}'),
                        ),
                        _ContactItem(
                          icon: Icons.link,
                          label: AppConstants.contactLinkedInLabel,
                          value: AppConstants.linkedInHandle,
                          onTap: () => _launchUrl(AppConstants.linkedInUrl),
                        ),
                        _ContactItem(
                          icon: Icons.code,
                          label: AppConstants.contactGithubLabel,
                          value: AppConstants.githubHandle,
                          onTap: () => _launchUrl(AppConstants.githubUrl),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
          ),

          SizedBox(
            height: responsive.getValue(
              mobile: AppConstants.spacing3xl,
              tablet: AppConstants.spacing4xl,
              desktop: AppConstants.spacing4xl * 1.5,
            ),
          ),

          // Footer
          const Divider(color: AppColors.glassBorder),
          const SizedBox(height: AppConstants.spacingLg),
          Text(
            '${AppConstants.footerMadeWith} ${AppConstants.name}',
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(color: AppColors.textSecondary),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppConstants.spacingSm),
          Text(
            '© ${DateTime.now().year} ${AppConstants.footerCopyright}',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: AppColors.textSecondary.withValues(alpha: 0.7),
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppConstants.spacingLg),
        ],
      ),
    );
  }
}

class _ContactItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final VoidCallback onTap;

  const _ContactItem({
    required this.icon,
    required this.label,
    required this.value,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppConstants.radiusMd),
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppConstants.spacingLg,
          vertical: AppConstants.spacingMd,
        ),
        decoration: BoxDecoration(
          color: Theme.of(
            context,
          ).colorScheme.surfaceContainerHigh.withValues(alpha: 0.3),
          borderRadius: BorderRadius.circular(AppConstants.radiusMd),
          border: Border.all(color: AppColors.glassBorder),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: AppColors.primaryBlue),
            const SizedBox(width: AppConstants.spacingMd),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
                Text(
                  value,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
