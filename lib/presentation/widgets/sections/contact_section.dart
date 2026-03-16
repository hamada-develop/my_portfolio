import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/utils/responsive.dart';
import '../common/gradient_text.dart';
import '../common/sections_container.dart';
import '../common/glass_card.dart';
import '../../../core/widgets/scroll_animate_in.dart';

class ContactSection extends StatefulWidget {
  const ContactSection({super.key});

  @override
  State<ContactSection> createState() => _ContactSectionState();
}

class _ContactSectionState extends State<ContactSection> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _messageController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  Future<void> _sendMessage() async {
    final name = _nameController.text;
    final email = _emailController.text;
    final message = _messageController.text;

    final subject = Uri.encodeComponent('Portfolio Contact from $name');
    final body = Uri.encodeComponent('Name: $name\nEmail: $email\n\n$message');

    final mailtoLink =
        'mailto:${AppConstants.email}?subject=$subject&body=$body';
    await _launchUrl(mailtoLink);
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

                  // Contact & Support Row for Layouts
                  responsive.isDesktop || responsive.isTablet
                      ? Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(child: _buildContactInfo(context)),
                            const SizedBox(width: AppConstants.spacingXxl),
                            Expanded(child: _buildMessageForm(context)),
                          ],
                        )
                      : Column(
                          children: [
                            _buildContactInfo(context),
                            const SizedBox(height: AppConstants.spacingXxl),
                            _buildMessageForm(context),
                          ],
                        ),

                  const SizedBox(height: AppConstants.spacingXxl),
                  const Divider(color: AppColors.glassBorder),
                  const SizedBox(height: AppConstants.spacingXl),

                  // Support Portfolio
                  Text(
                    AppConstants.sectionTitleSupport,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: AppConstants.spacingMd),
                  Text(
                    AppConstants.supportMessage,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: AppConstants.spacingLg),
                  Wrap(
                    spacing: AppConstants.spacingLg,
                    runSpacing: AppConstants.spacingMd,
                    alignment: WrapAlignment.center,
                    children: [
                      _SupportItem(
                        icon: Icons.coffee,
                        label: 'Buy me a Coffee',
                        color: Colors.orange,
                        onTap: () => _launchUrl(AppConstants.buyMeACoffeeUrl),
                      ),
                      _SupportItem(
                        icon: Icons.favorite,
                        label: 'Patreon',
                        color: AppColors.primaryPink,
                        onTap: () => _launchUrl(AppConstants.patreonUrl),
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

  Widget _buildContactInfo(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Direct Contact",
          style: Theme.of(
            context,
          ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: AppConstants.spacingLg),
        Wrap(
          spacing: AppConstants.spacingXl,
          runSpacing: AppConstants.spacingLg,
          children: [
            _ContactItem(
              icon: Icons.email_rounded,
              label: AppConstants.contactEmailLabel,
              value: AppConstants.email,
              onTap: () => _launchUrl('mailto:${AppConstants.email}'),
            ),
            _ContactItem(
              icon: Icons.link_rounded,
              label: AppConstants.contactLinkedInLabel,
              value: AppConstants.linkedInHandle,
              onTap: () => _launchUrl(AppConstants.linkedInUrl),
            ),
            _ContactItem(
              icon: Icons.code_rounded,
              label: AppConstants.contactGithubLabel,
              value: AppConstants.githubHandle,
              onTap: () => _launchUrl(AppConstants.githubUrl),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildMessageForm(BuildContext context) {
    final isLight = Theme.of(context).brightness == Brightness.light;
    final fillColor = isLight ? Colors.white : AppColors.glassOverlayDark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Send a Message",
          style: Theme.of(
            context,
          ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: AppConstants.spacingLg),
        TextField(
          controller: _nameController,
          decoration: InputDecoration(
            hintText: AppConstants.messageNameHint,
            filled: true,
            fillColor: fillColor,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppConstants.radiusMd),
              borderSide: const BorderSide(color: AppColors.glassBorder),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppConstants.radiusMd),
              borderSide: const BorderSide(color: AppColors.glassBorder),
            ),
          ),
        ),
        const SizedBox(height: AppConstants.spacingMd),
        TextField(
          controller: _emailController,
          decoration: InputDecoration(
            hintText: AppConstants.messageEmailHint,
            filled: true,
            fillColor: fillColor,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppConstants.radiusMd),
              borderSide: const BorderSide(color: AppColors.glassBorder),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppConstants.radiusMd),
              borderSide: const BorderSide(color: AppColors.glassBorder),
            ),
          ),
        ),
        const SizedBox(height: AppConstants.spacingMd),
        TextField(
          controller: _messageController,
          maxLines: 4,
          decoration: InputDecoration(
            hintText: AppConstants.messageBodyHint,
            filled: true,
            fillColor: fillColor,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppConstants.radiusMd),
              borderSide: const BorderSide(color: AppColors.glassBorder),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppConstants.radiusMd),
              borderSide: const BorderSide(color: AppColors.glassBorder),
            ),
          ),
        ),
        const SizedBox(height: AppConstants.spacingLg),
        SizedBox(
          width: double.infinity,
          height: 48,
          child: ElevatedButton.icon(
            onPressed: _sendMessage,
            icon: const Icon(Icons.send_rounded, color: Colors.white),
            label: const Text(
              AppConstants.messageSendButton,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryPurple,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppConstants.radiusMd),
              ),
            ),
          ),
        ),
      ],
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
            Container(
              padding: const EdgeInsets.all(AppConstants.spacingSm),
              decoration: BoxDecoration(
                color: AppColors.primaryBlue.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(AppConstants.radiusSm),
              ),
              child: Icon(icon, color: AppColors.primaryBlue),
            ),
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
                    color: Theme.of(context).colorScheme.onSurface,
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

class _SupportItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  const _SupportItem({
    required this.icon,
    required this.label,
    required this.color,
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
          color: color.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(AppConstants.radiusMd),
          border: Border.all(color: color.withValues(alpha: 0.3)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: color),
            const SizedBox(width: AppConstants.spacingMd),
            Text(
              label,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
