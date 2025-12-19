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
    final screenHeight = MediaQuery.sizeOf(context).height;

    return Container(
      // 1. تحديد الحد الأدنى للطول ليكون بحجم الشاشة
      constraints: BoxConstraints(minHeight: screenHeight),
      width: double.infinity,
      child: Stack(
        // 2. محاذاة العناصر غير المثبتة (المحتوى) في المنتصف
        alignment: Alignment.center,
        children: [
          // --- الخلفية (الصورة) ---
          // نستخدم Positioned عادي لأننا لا نعتمد عليه في حساب الطول
          PositionedDirectional(
            end: 0,
            top: 0, // ثبتنا الصورة في الأعلى
            child: Image.asset(
              'assets/hamada3.png',
              height: 1000,
              width: 700,
              fit: BoxFit.cover,
            ),
          ),

          // --- طبقة التعتيم (Gradient) ---
          // نستخدم Positioned.fill لتملأ المساحة التي سيحددها المحتوى والكونتينر
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    const Color(0xFF11071F).withOpacity(0.63),
                    const Color(0xFF11071F).withOpacity(0.95),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
          ),

          // --- المحتوى الأساسي (تم إزالة Positioned.fill منه) ---
          // هذا هو "العمود الفقري" الذي سيحدد طول الـ Stack
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
                desktop: AppConstants.spacing4xl,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              // mainAxisSize: MainAxisSize.min, // لا نحتاجها هنا لأننا نريد التمدد الطبيعي
              children: [

                // Animated Flutter Icon
                AnimatedBuilder(
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
                        child: Icon(Icons.code,
                            size: responsive.getValue(mobile: 50, tablet: 70, desktop: 80),
                            color: Colors.white
                        ),
                      ),
                    );
                  },
                ),

                SizedBox(height: responsive.getValue(mobile: 24, tablet: 32, desktop: 40)),

                // Greeting
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Hello! I Am ',
                      style: AppTextStyles.heroAccent.copyWith(
                        fontSize: responsive.getValue(mobile: 16, tablet: 18, desktop: 20),
                      ),
                      textAlign: TextAlign.center,
                    ),
                    GradientText(
                      text: AppConstants.name,
                      gradient: AppColors.textGradient,
                      style: AppTextStyles.heroAccent.copyWith(
                        fontSize: responsive.getValue(mobile: 16, tablet: 18, desktop: 20),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),

                SizedBox(height: responsive.getValue(mobile: 16, tablet: 24, desktop: 32)),

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

                SizedBox(height: responsive.getValue(mobile: 40, tablet: 60, desktop: 80)),

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

                SizedBox(height: responsive.getValue(mobile: 16, tablet: 24, desktop: 32)),

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