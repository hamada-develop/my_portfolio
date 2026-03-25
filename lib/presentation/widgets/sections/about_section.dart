import 'package:flutter/material.dart';

import '../../../core/constants/app_constants.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/utils/responsive.dart';
import '../common/gradient_text.dart';
import '../common/sections_container.dart';
import 'package:flutter_animate/flutter_animate.dart';

class AboutSection extends StatefulWidget {
  const AboutSection({super.key});

  @override
  State<AboutSection> createState() => _AboutSectionState();
}

class _AboutSectionState extends State<AboutSection> {
  final color1 = AppColors.glassOverlayDark.withValues(alpha: 0.63);
  final color2 = AppColors.glassOverlayDark.withValues(alpha: 0.95);

  @override
  Widget build(BuildContext context) {
    final responsive = context.responsive;
    final screenHeight = MediaQuery.sizeOf(context).height;
    final screenWidth = MediaQuery.sizeOf(context).width;
    print('SCREEN WIDTH ${screenWidth}');

    return Container(
      constraints: BoxConstraints(minHeight: screenHeight),
      width: double.infinity,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Animated Background Image
          PositionedDirectional(
            end: 0,
            top: 0,
            child:
                Image.asset(
                      AppConstants.avatarPrimary,
                      height: responsive.getValue(
                        mobile: screenHeight,
                        desktop: screenHeight,
                        tablet: screenHeight - 50,
                      ),
                      width: responsive.getValue(
                        mobile: 500,
                        desktop: 600,
                        tablet: 500,
                      ),
                      fit: BoxFit.cover,
                      frameBuilder:
                          (context, child, frame, wasSynchronouslyLoaded) {
                            if (wasSynchronouslyLoaded) return child;
                            return AnimatedOpacity(
                              opacity: frame == null ? 0 : 1,
                              duration: const Duration(milliseconds: 600),
                              curve: Curves.easeOut,
                              child: child,
                            );
                          },
                    )
                    .animate()
                    .fadeIn(duration: 800.ms, curve: Curves.easeOut)
                    .scale(
                      begin: const Offset(1.1, 1.1),
                      end: const Offset(1.0, 1.0),
                      duration: 1200.ms,
                      curve: Curves.easeOutCubic,
                    ),
          ),

          // Animated Gradient Overlay
          Positioned.fill(
            child:
                Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [color1, color2],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                      ),
                    )
                    .animate()
                    .fadeIn(duration: 600.ms)
                    .shimmer(
                      duration: 2000.ms,
                      delay: 800.ms,
                      color: AppColors.primaryPink.withValues(alpha: 0.3),
                    ),
          ),

          SectionContainer(
            padding: EdgeInsets.symmetric(
              horizontal: responsive.getValue(
                mobile: AppConstants.spacingMd,
                tablet: AppConstants.spacingXl,
                desktop: AppConstants.spacingXl,
              ),
            ),
            child: Column(
              mainAxisAlignment: responsive.width <= 903 ? .center : .start,
              children: [
                SizedBox(
                  height: responsive.getValue(
                    mobile: 15,
                    tablet: 30,
                    desktop: responsive.width < 1450 ? 30 : 80,
                  ),
                ),
                // Main Tagline with Cascading Animation
                Column(
                  children: [
                    SelectableText(
                          AppConstants.heroLine1,
                          style: AppTextStyles.heroTitleResponsive(context),
                          textAlign: TextAlign.center,
                        )
                        .animate()
                        .fadeIn(duration: 700.ms, delay: 400.ms)
                        .slideX(
                          begin: -0.2,
                          end: 0,
                          duration: 700.ms,
                          delay: 400.ms,
                          curve: Curves.easeOutCubic,
                        ),
                    GradientText(
                          text: AppConstants.heroLine2,
                          gradient: AppColors.purplePinkGradient,
                          style: AppTextStyles.heroTitleResponsive(context),
                          textAlign: TextAlign.center,
                        )
                        .animate()
                        .fadeIn(duration: 700.ms, delay: 700.ms)
                        .slideX(
                          begin: 0.2,
                          end: 0,
                          duration: 700.ms,
                          delay: 700.ms,
                          curve: Curves.easeOutCubic,
                        )
                        .shimmer(
                          duration: 10000.ms,
                          delay: 1400.ms,
                          color: Colors.white.withValues(alpha: 0.4),
                        ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children:
                          [
                                SelectableText(
                                  AppConstants.heroLine3Prefix,
                                  style: AppTextStyles.heroTitleResponsive(
                                    context,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                GradientText(
                                      text: AppConstants.heroLine3Highlight,
                                      gradient: AppColors.cyanGradient,
                                      style: AppTextStyles.heroTitleResponsive(
                                        context,
                                      ),
                                      textAlign: TextAlign.center,
                                    )
                                    .animate()
                                    .scale(
                                      begin: const Offset(0.8, 0.8),
                                      duration: 600.ms,
                                      delay: 1000.ms,
                                      curve: Curves.elasticOut,
                                    )
                                    .shimmer(
                                      duration: 10000.ms,
                                      delay: 1400.ms,
                                      color: Colors.white.withValues(
                                        alpha: 0.5,
                                      ),
                                    ),
                                SelectableText(
                                  AppConstants.heroLine3Suffix,
                                  style: AppTextStyles.heroTitleResponsive(
                                    context,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ]
                              .animate(interval: 200.ms)
                              .fadeIn(duration: 700.ms, delay: 900.ms)
                              .slideY(
                                begin: 0.3,
                                end: 0,
                                duration: 700.ms,
                                curve: Curves.easeOutCubic,
                              ),
                    ),
                  ],
                ),

                SizedBox(
                  height: responsive.getValue(
                    mobile: 40,
                    tablet: 60,
                    desktop: responsive.width < 1450 ? 60 : 80,
                  ),
                ),
                // Name
                SelectableText(
                      AppConstants.name,
                      style: AppTextStyles.h1(context).copyWith(
                        fontSize: responsive.getValue(
                          mobile: 40,
                          tablet: 56,
                          desktop: 72,
                        ),
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        letterSpacing: -1.5,
                      ),
                      textAlign: TextAlign.center,
                    )
                    .animate()
                    .fadeIn(duration: 800.ms, delay: 200.ms)
                    .slideY(begin: 0.2, curve: Curves.easeOut),

                SizedBox(
                  height: responsive.getValue(
                    mobile: 16,
                    tablet: 20,
                    desktop: responsive.width < 1450 ? 12 : 24,
                  ),
                ),

                // Title Row
                Wrap(
                      alignment: WrapAlignment.center,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      spacing: 8,
                      runSpacing: 4,
                      children: [
                        SelectableText(
                          AppConstants.profileTitlePrimary,
                          style: AppTextStyles.h3(context).copyWith(
                            color: AppColors.primaryCyan,
                            fontWeight: FontWeight.bold,
                            fontSize: responsive.getValue(
                              mobile: 18,
                              tablet: 24,
                              desktop: 28,
                            ),
                          ),
                        ),
                        SelectableText(
                          '|',
                          style: AppTextStyles.h3(context).copyWith(
                            color: AppColors.primaryCyan,
                            fontSize: responsive.getValue(
                              mobile: 18,
                              tablet: 24,
                              desktop: 28,
                            ),
                          ),
                        ),
                        SelectableText(
                          AppConstants.profileTitleSecondary,
                          style: AppTextStyles.h3(context).copyWith(
                            color: AppColors.primaryCyan,
                            fontWeight: FontWeight.bold,
                            fontSize: responsive.getValue(
                              mobile: 18,
                              tablet: 24,
                              desktop: 28,
                            ),
                          ),
                        ),
                      ],
                    )
                    .animate()
                    .fadeIn(duration: 800.ms, delay: 400.ms)
                    .slideY(begin: 0.2, curve: Curves.easeOut),

                SizedBox(
                  height: responsive.getValue(
                    mobile: 24,
                    tablet: 28,
                    desktop: responsive.width < 1450 ? 12 : 32,
                  ),
                ),

                // Location and Availability
                Wrap(
                      alignment: WrapAlignment.center,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      spacing: 12,
                      runSpacing: 12,
                      children: [
                        _InfoChip(
                          icon: Icons.location_on_outlined,
                          text: AppConstants.profileLocation,
                          responsive: responsive,
                        ),
                        if (responsive.width > 600) _DotSeparator(),
                        _InfoChip(
                          icon: Icons.circle,
                          iconSize: 10,
                          iconColor: const Color(0xFF10B981),
                          // Green dot
                          text: AppConstants.profileOpenToRemote,
                          responsive: responsive,
                        ),
                        if (responsive.width > 600) _DotSeparator(),
                        _InfoChip(
                          text: AppConstants.profileAvailableForRelocation,
                          responsive: responsive,
                        ),
                      ],
                    )
                    .animate()
                    .fadeIn(duration: 800.ms, delay: 600.ms)
                    .slideY(begin: 0.2, curve: Curves.easeOut),

                SizedBox(
                  height: responsive.getValue(
                    mobile: 40,
                    tablet: 60,
                    desktop: responsive.width < 1450 ? 50 : 80,
                  ),
                ),

                // Stats Row
                _buildStatsRow(context, responsive)
                    .animate()
                    .fadeIn(duration: 800.ms, delay: 800.ms)
                    .slideY(begin: 0.2, curve: Curves.easeOut),

                SizedBox(
                  height: responsive.getValue(
                    mobile: 40,
                    tablet: 60,
                    desktop: responsive.width < 1450 ? 50 : 80,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatsRow(BuildContext context, Responsive responsive) {
    if (responsive.isMobile) {
      return Wrap(
        alignment: WrapAlignment.center,
        spacing: 32,
        runSpacing: 32,
        children: const [
          _StatItem(
            value: AppConstants.statYearsExperienceValue,
            label: AppConstants.statYearsExperienceLabel,
          ),
          _StatItem(
            value: AppConstants.statAppsBuiltValue,
            label: AppConstants.statAppsBuiltLabel,
          ),
          _StatItem(
            value: AppConstants.statDownloadsValue,
            label: AppConstants.statDownloadsLabel,
          ),
          _StatItem(
            value: AppConstants.statOpenSourceValue,
            label: AppConstants.statOpenSourceLabel,
          ),
        ],
      );
    }

    return IntrinsicHeight(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const _StatItem(
            value: AppConstants.statYearsExperienceValue,
            label: AppConstants.statYearsExperienceLabel,
          ),
          _buildVerticalDivider(responsive),
          const _StatItem(
            value: AppConstants.statAppsBuiltValue,
            label: AppConstants.statAppsBuiltLabel,
          ),
          _buildVerticalDivider(responsive),
          const _StatItem(
            value: AppConstants.statDownloadsValue,
            label: AppConstants.statDownloadsLabel,
          ),
          _buildVerticalDivider(responsive),
          const _StatItem(
            value: AppConstants.statOpenSourceValue,
            label: AppConstants.statOpenSourceLabel,
          ),
        ],
      ),
    );
  }

  Widget _buildVerticalDivider(Responsive responsive) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: responsive.getValue(mobile: 16, tablet: 24,
            desktop: responsive.width < 1450 ? 20 : 40,),
      ),
      child: VerticalDivider(
        color: AppColors.glassBorder,
        thickness: 1,
        indent: 4,
        endIndent: 4,
      ),
    );
  }
}

class _InfoChip extends StatelessWidget {
  final IconData? icon;
  final double? iconSize;
  final Color? iconColor;
  final String text;
  final Responsive responsive;

  const _InfoChip({
    this.icon,
    this.iconSize,
    this.iconColor,
    required this.text,
    required this.responsive,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (icon != null) ...[
          Icon(
            icon,
            size:
                iconSize ??
                responsive.getValue(mobile: 16, tablet: 18, desktop: 20),
            color: iconColor ?? AppColors.textSecondary,
          ),
          const SizedBox(width: 8),
        ],
        SelectableText(
          text,
          style: AppTextStyles.bodyMedium(context).copyWith(
            color: AppColors.textSecondary,
            fontSize: responsive.getValue(mobile: 14, tablet: 16, desktop: 18),
          ),
        ),
      ],
    );
  }
}

class _DotSeparator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SelectableText(
      '•',
      style: TextStyle(color: AppColors.textTertiary, fontSize: 18),
    );
  }
}

class _StatItem extends StatelessWidget {
  final String value;
  final String label;

  const _StatItem({required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    final responsive = context.responsive;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SelectableText(
          value,
          style: AppTextStyles.h2(context).copyWith(
            color: AppColors.primaryCyan,
            fontWeight: FontWeight.bold,
            fontSize: responsive.getValue(
              mobile: 10,
              tablet: 10,
              desktop: responsive.width < 1450 ? 32 : 48,

              // mobile: 32,
              // tablet: 10,
              // desktop: responsive.width < 1440 ? 10 : 48,
            ),
          ),
        ),
        const SizedBox(height: 8),
        SelectableText(
          label,
          style: AppTextStyles.bodyMedium(context).copyWith(
            color: AppColors.textSecondary,
            fontSize: responsive.getValue(mobile: 12, tablet: 14, desktop: 16),
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
