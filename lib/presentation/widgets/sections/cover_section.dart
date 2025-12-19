import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/utils/responsive.dart';
import '../common/gradient_text.dart';
import '../common/sections_container.dart';

class CoverSection extends StatefulWidget {
  const CoverSection({super.key});

  @override
  State<CoverSection> createState() => _CoverSectionState();
}

class _CoverSectionState extends State<CoverSection>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _floatAnimation;

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
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final responsive = context.responsive;
    return Stack(
      children: [
        PositionedDirectional(
          end: 0,
          child: Image.asset(
            'assets/hamada2.png',
            height: 1000,
            width: 700,
          ),
        ),
        Positioned.fill(
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  const Color(0xFF11071F).withOpacity(0.63), // surface tone
                  const Color(0xFF11071F).withOpacity(0.75),
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
              desktop: AppConstants.spacing3xl,
            ),
            vertical: responsive.getValue(
              mobile: AppConstants.spacing3xl,
              tablet: AppConstants.spacing4xl,
              desktop: AppConstants.spacing4xl * 1.5,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // Animated Flutter Icon
              AnimatedBuilder(
                animation: _floatAnimation,
                builder: (context, child) {
                  return Transform.translate(
                    offset: Offset(0, _floatAnimation.value),
                    child: Container(
                      width: responsive.getValue(
                        mobile: 120,
                        tablet: 150,
                        desktop: 180,
                      ),
                      height: responsive.getValue(
                        mobile: 120,
                        tablet: 150,
                        desktop: 180,
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
                      child: const Icon(Icons.code, size: 80, color: Colors.white),
                    ),
                  );
                },
              ),

              SizedBox(
                height: responsive.getValue(
                  mobile: AppConstants.spacingXl,
                  tablet: AppConstants.spacingXxl,
                  desktop: AppConstants.spacing3xl,
                ),
              ),
              // Greeting
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
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

              SizedBox(
                height: responsive.getValue(
                  mobile: AppConstants.spacingLg,
                  tablet: AppConstants.spacingXl,
                  desktop: AppConstants.spacingXxl,
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
                  mobile: AppConstants.spacingMd,
                  tablet: AppConstants.spacingLg,
                  desktop: AppConstants.spacingXl,
                ),
              ),

              // Tagline subtext
              // Text(
              //   AppConstants.taglineSubtext,
              //   style: AppTextStyles.heroSubtitle.copyWith(
              //     fontSize: responsive.getValue(
              //       mobile: 16,
              //       tablet: 18,
              //       desktop: 20,
              //     ),
              //   ),
              //   textAlign: TextAlign.center,
              // ),
              //
              // SizedBox(
              //   height: responsive.getValue(
              //     mobile: AppConstants.spacingXl,
              //     tablet: AppConstants.spacingXxl,
              //     desktop: AppConstants.spacing3xl,
              //   ),
              // ),

            ],
          ),
        ),
      ],
    );
  }
}
