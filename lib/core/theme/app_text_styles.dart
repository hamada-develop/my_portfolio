import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

class AppTextStyles {
  AppTextStyles._();

  // Hero Text Styles
  static TextStyle heroTitle(BuildContext context) => GoogleFonts.inter(
    fontSize: 72,
    fontWeight: FontWeight.bold,
    color: context.adaptiveTextPrimary,
    letterSpacing: -1.5,
  );

  static TextStyle heroSubtitle(BuildContext context) => GoogleFonts.inter(
    fontSize: 20,
    fontWeight: FontWeight.w400,
    color: context.adaptiveTextSecondary,
    height: 1.6,
  );

  static TextStyle heroAccent(BuildContext context) => GoogleFonts.inter(
    fontSize: 18,
    fontWeight: FontWeight.w500,
    color: AppColors.accentPurpleLight,
    letterSpacing: 0.5,
  );

  // Heading Styles
  static TextStyle h1(BuildContext context) => GoogleFonts.inter(
    fontSize: 48,
    fontWeight: FontWeight.bold,
    color: context.adaptiveTextPrimary,
    height: 1.2,
  );

  static TextStyle h2(BuildContext context) => GoogleFonts.inter(
    fontSize: 36,
    fontWeight: FontWeight.bold,
    color: context.adaptiveTextPrimary,
    height: 1.3,
  );

  static TextStyle h3(BuildContext context) => GoogleFonts.inter(
    fontSize: 28,
    fontWeight: FontWeight.bold,
    color: context.adaptiveTextPrimary,
    height: 1.4,
  );

  static TextStyle h4(BuildContext context) => GoogleFonts.inter(
    fontSize: 24,
    fontWeight: FontWeight.w600,
    color: context.adaptiveTextPrimary,
    height: 1.4,
  );

  static TextStyle h5(BuildContext context) => GoogleFonts.inter(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: context.adaptiveTextPrimary,
    height: 1.4,
  );

  // Body Text Styles
  static TextStyle bodyLarge(BuildContext context) => GoogleFonts.inter(
    fontSize: 18,
    fontWeight: FontWeight.w400,
    color: context.adaptiveTextSecondary,
    height: 1.6,
  );

  static TextStyle bodyMedium(BuildContext context) => GoogleFonts.inter(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: context.adaptiveTextSecondary,
    height: 1.5,
  );

  static TextStyle bodySmall(BuildContext context) => GoogleFonts.inter(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: context.adaptiveTextTertiary,
    height: 1.5,
  );

  // Label Styles
  static TextStyle label(BuildContext context) => GoogleFonts.inter(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: context.adaptiveTextSecondary,
    letterSpacing: 0.5,
  );

  static TextStyle labelSmall(BuildContext context) => GoogleFonts.inter(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    color: context.adaptiveTextTertiary,
    letterSpacing: 0.5,
  );

  // Special Styles
  static TextStyle gradient(BuildContext context) => GoogleFonts.inter(
    fontSize: 48,
    fontWeight: FontWeight.bold,
    height: 1.2,
  );

  static TextStyle button(BuildContext context) => GoogleFonts.inter(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: context.adaptiveTextPrimary,
    letterSpacing: 0.5,
  );

  static TextStyle navItem(BuildContext context) => GoogleFonts.inter(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: context.adaptiveTextSecondary,
  );

  static TextStyle tag(BuildContext context) => GoogleFonts.inter(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    color: context.adaptiveTextSecondary,
  );

  // Responsive helpers
  static TextStyle heroTitleResponsive(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    if (width < 600) {
      return heroTitle(context).copyWith(fontSize: 40);
    } else if (width < 1024) {
      return heroTitle(context).copyWith(fontSize: 56);
    }
    return heroTitle(context);
  }

  static TextStyle h1Responsive(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    if (width < 600) {
      return h1(context).copyWith(fontSize: 32);
    } else if (width < 1024) {
      return h1(context).copyWith(fontSize: 40);
    }
    return h1(context);
  }
}