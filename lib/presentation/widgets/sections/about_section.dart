import 'package:flutter/material.dart';

import '../../../core/constants/app_constants.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/utils/responsive.dart';
import '../common/gradient_text.dart';
import '../common/sections_container.dart';

class AboutSection extends StatefulWidget {
  const AboutSection({super.key});

  @override
  State<AboutSection> createState() => _AboutSectionState();
}

class _AboutSectionState extends State<AboutSection>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _floatAnimation;

  final color1 = Color(0xFF11071F).withOpacity(0.63);
  final color2 = Color(0xFF11071F).withOpacity(0.95);

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
            ),
          ),

          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    color1,
                    color2,
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
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
              mainAxisAlignment: responsive.width <= 903
                  ? .center
                  : .start,
              children: [
                Visibility(
                  visible: responsive.width > 903,
                  child: Padding(
                    padding:  EdgeInsetsDirectional.only(end: responsive.width < 1330? 60: 0),
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
                    ),
                  ),
                ),
                SizedBox(
                  height: responsive.getValue(
                    mobile: 24,
                    tablet: 32,
                    desktop: responsive.width < 1330? 32: 40,
                  ),
                ),

                // Greeting
                Padding(
                  padding: EdgeInsetsDirectional.only(
                      end: responsive.width < 1330 && responsive.width > 903 ? 60 : 0),
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
                      ),
                    ],
                  ),
                ),

                SizedBox(
                  height: responsive.getValue(
                    mobile: 16,
                    tablet: 24,
                    desktop: responsive.width < 1330? 24: 32,
                  ),
                ),

                // Main Tagline
                Column(
                  children: [
                    Text(
                      'A Developer who',
                      style: AppTextStyles.heroTitleResponsive(context),
                      textAlign: TextAlign.center,
                    ),
                    GradientText(
                      text: 'Judges a book',
                      gradient: AppColors.purplePinkGradient,
                      style: AppTextStyles.heroTitleResponsive(context),
                      textAlign: TextAlign.center,
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
                        ),
                        Text(
                          '...',
                          style: AppTextStyles.heroTitleResponsive(context),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ],
                ),

                SizedBox(
                  height: responsive.getValue(
                    mobile: 40,
                    tablet: 60,
                    desktop: responsive.width < 1330? 60: 80,
                  ),
                ),

                // Title & Bio
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
                ),

                SizedBox(
                  height: responsive.getValue(
                    mobile: 16,
                    tablet: 24,
                    desktop: 32,
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
                      color: Colors.white70,
                    ),
                    textAlign: TextAlign.center,
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
    super.key,
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
