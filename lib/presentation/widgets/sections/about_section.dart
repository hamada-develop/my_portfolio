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

class _AboutSectionState extends State<AboutSection>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _floatAnimation;

  final color1 = Color(0xFF11071F).withValues(alpha: 0.63);
  final color2 = Color(0xFF11071F).withValues(alpha: 0.95);

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _floatAnimation = Tween<double>(
      begin: 0,
      end: -40,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    _controller.repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.stop();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final responsive = context.responsive;
    final screenHeight = MediaQuery.sizeOf(context).height;

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
            child: Image.asset(
              'assets/hamada3.png',
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
            child: Container(
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
              vertical: responsive.getValue(
                mobile: AppConstants.spacing3xl,
                tablet: AppConstants.spacing3xl,
                desktop: AppConstants.spacing3xl,
              ),
            ),
            child: Column(
              mainAxisAlignment: responsive.width <= 903 ? .center : .start,
              children: [
                // Floating Icon with Advanced Animations
                Visibility(
                  visible: responsive.width > 903,
                  child: Padding(
                    padding: EdgeInsetsDirectional.only(
                      end: responsive.width < 1330 ? 60 : 0,
                    ),
                    child: AnimatedBuilder(
                      animation: _floatAnimation,
                      builder: (context, child) {
                        return Transform.translate(
                          offset: Offset(0, _floatAnimation.value),
                          child: Container(
                            width: responsive.getValue(
                              mobile: 100,
                              tablet: 130,
                              desktop: 160,
                            ),
                            height: responsive.getValue(
                              mobile: 100,
                              tablet: 130,
                              desktop: 160,
                            ),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: AppColors.primaryGradient,
                              boxShadow: [
                                BoxShadow(
                                  color: AppColors.purpleShadow,
                                  blurRadius: 40,
                                  spreadRadius: 10,
                                ),
                              ],
                            ),
                            child: Icon(
                              Icons.code,
                              size: responsive.getValue(
                                mobile: 50,
                                tablet: 70,
                                desktop: 80,
                              ),
                              color: Colors.white,
                            ),
                          ),
                        );
                      },
                    )
                        .animate()
                        .fadeIn(duration: 600.ms, delay: 200.ms)
                        .scale(
                      begin: const Offset(0.5, 0.5),
                      duration: 800.ms,
                      delay: 200.ms,
                      curve: Curves.elasticOut,
                    ),
                  ),
                ),
                SizedBox(
                  height: responsive.getValue(
                    mobile: 24,
                    tablet: 32,
                    desktop: responsive.width < 1330 ? 32 : 40,
                  ),
                ),

                // Greeting with Staggered Animation
                Padding(
                  padding: EdgeInsetsDirectional.only(
                    end: responsive.width < 1330 && responsive.width > 903
                        ? 60
                        : 0,
                  ),
                  child: _GreetingElement(
                    responsive: responsive,
                    children: [
                      Text(
                        'Hello! I Am ',
                        style: AppTextStyles.heroAccent.copyWith(
                          fontSize: responsive.getValue(
                            mobile: 16,
                            tablet: 18,
                            desktop: 20,
                          ),
                        ),
                        textAlign: TextAlign.center,
                      )
                          .animate()
                          .fadeIn(duration: 600.ms, delay: 400.ms)
                          .slideY(
                        begin: -0.3,
                        end: 0,
                        duration: 600.ms,
                        delay: 400.ms,
                        curve: Curves.easeOutCubic,
                      ),
                      GradientText(
                        text: AppConstants.name,
                        gradient: AppColors.textGradient,
                        style: AppTextStyles.heroAccent.copyWith(
                          fontSize: responsive.getValue(
                            mobile: 16,
                            tablet: 18,
                            desktop: 20,
                          ),
                        ),
                        textAlign: TextAlign.center,
                      )
                          .animate()
                          .fadeIn(duration: 600.ms, delay: 600.ms)
                          .slideY(
                        begin: -0.3,
                        end: 0,
                        duration: 600.ms,
                        delay: 600.ms,
                        curve: Curves.easeOutCubic,
                      )
                          .shimmer(
                        duration: 1500.ms,
                        delay: 1200.ms,
                        color: Colors.white.withValues(alpha: 0.5),
                      ),
                    ],
                  ),
                ),

                SizedBox(
                  height: responsive.getValue(
                    mobile: 16,
                    tablet: 24,
                    desktop: responsive.width < 1330 ? 24 : 32,
                  ),
                ),

                // Main Tagline with Cascading Animation
                Column(
                  children: [
                    Text(
                      'A Developer who',
                      style: AppTextStyles.heroTitleResponsive(context),
                      textAlign: TextAlign.center,
                    )
                        .animate()
                        .fadeIn(duration: 700.ms, delay: 800.ms)
                        .slideX(
                      begin: -0.2,
                      end: 0,
                      duration: 700.ms,
                      delay: 800.ms,
                      curve: Curves.easeOutCubic,
                    ),
                    GradientText(
                      text: 'Judges a book',
                      gradient: AppColors.purplePinkGradient,
                      style: AppTextStyles.heroTitleResponsive(context),
                      textAlign: TextAlign.center,
                    )
                        .animate()
                        .fadeIn(duration: 700.ms, delay: 1100.ms)
                        .slideX(
                      begin: 0.2,
                      end: 0,
                      duration: 700.ms,
                      delay: 1100.ms,
                      curve: Curves.easeOutCubic,
                    )
                        .shimmer(
                      duration: 10000.ms,
                      delay: 1800.ms,
                      color: Colors.white.withValues(alpha: 0.4),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'by its ',
                          style: AppTextStyles.heroTitleResponsive(context),
                          textAlign: TextAlign.center,
                        ),
                        GradientText(
                          text: 'cover',
                          gradient: AppColors.cyanGradient,
                          style: AppTextStyles.heroTitleResponsive(context),
                          textAlign: TextAlign.center,
                        )
                            .animate()
                            .scale(
                          begin: const Offset(0.8, 0.8),
                          duration: 600.ms,
                          delay: 1600.ms,
                          curve: Curves.elasticOut,
                        )
                            .shimmer(
                          duration: 10000.ms,
                          delay: 2200.ms,
                          color: Colors.white.withValues(alpha: 0.5),
                        ),
                        Text(
                          '...',
                          style: AppTextStyles.heroTitleResponsive(context),
                          textAlign: TextAlign.center,
                        ),
                      ]
                          .animate(interval: 200.ms)
                          .fadeIn(duration: 700.ms, delay: 1400.ms)
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
                    desktop: responsive.width < 1330 ? 60 : 80,
                  ),
                ),

                // Title with Blur Effect
                Text(
                  'I\'m a ${AppConstants.title}.',
                  style: AppTextStyles.h3.copyWith(
                    fontSize: responsive.getValue(
                      mobile: 20,
                      tablet: 24,
                      desktop: 28,
                    ),
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                )
                    .animate()
                    .fadeIn(duration: 800.ms, delay: 1800.ms)
                    .blur(
                  begin: const Offset(4, 4),
                  end: const Offset(0, 0),
                  duration: 800.ms,
                  delay: 1800.ms,
                )
                    .slideY(
                  begin: 0.2,
                  end: 0,
                  duration: 800.ms,
                  delay: 1800.ms,
                  curve: Curves.easeOutCubic,
                ),

                SizedBox(
                  height: responsive.getValue(
                    mobile: 16,
                    tablet: 24,
                    desktop: 32,
                  ),
                ),

                // Bio with Fade and Slide
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
                      color: Colors.white70,
                    ),
                    textAlign: TextAlign.center,
                  )
                      .animate()
                      .fadeIn(duration: 1000.ms, delay: 2200.ms)
                      .slideY(
                    begin: 0.3,
                    end: 0,
                    duration: 1000.ms,
                    delay: 2200.ms,
                    curve: Curves.easeOutCubic,
                  )
                      .blur(
                    begin: const Offset(2, 2),
                    end: const Offset(0, 0),
                    duration: 1000.ms,
                    delay: 2200.ms,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _GreetingElement extends StatelessWidget {
  final List<Widget> children;
  final Responsive responsive;

  const _GreetingElement({
    required this.children,
    required this.responsive,
  });

  @override
  Widget build(BuildContext context) {
    if (responsive.width < 1330) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: children,
      );
    } else {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: children,
      );
    }
  }
}