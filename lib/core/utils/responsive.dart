import 'package:flutter/material.dart';
import '../constants/app_constants.dart';

class Responsive {
  final BuildContext context;

  Responsive(this.context);

  double get width => MediaQuery.of(context).size.width;
  double get height => MediaQuery.of(context).size.height;

  bool get isMobile => width < AppConstants.breakpointMobile;
  bool get isTablet => width >= AppConstants.breakpointMobile &&
      width < AppConstants.breakpointTablet;
  bool get isDesktop => width >= AppConstants.breakpointTablet;

  // Get value based on screen size
  T getValue<T>({
    required T mobile,
    T? tablet,
    required T desktop,
  }) {
    if (isDesktop) return desktop;
    if (isTablet) return tablet ?? desktop;
    return mobile;
  }

  // Responsive padding
  EdgeInsets get pagePadding => EdgeInsets.symmetric(
    horizontal: getValue(
      mobile: AppConstants.spacingMd,
      tablet: AppConstants.spacingXl,
      desktop: AppConstants.spacing3xl,
    ),
    vertical: AppConstants.spacingXl,
  );

  // Max width for content
  double get maxContentWidth => getValue(
    mobile: double.infinity,
    tablet: AppConstants.maxWidthLg,
    desktop: AppConstants.maxWidthXl,
  );

  // Grid columns
  int get gridColumns => getValue(
    mobile: 1,
    tablet: 2,
    desktop: 3,
  );

  // Font scaling
  double fontScale(double baseSize) => getValue(
    mobile: baseSize * 0.8,
    tablet: baseSize * 0.9,
    desktop: baseSize,
  );
}

// Extension for easy access
extension ResponsiveExtension on BuildContext {
  Responsive get responsive => Responsive(this);
  bool get isMobile => Responsive(this).isMobile;
  bool get isTablet => Responsive(this).isTablet;
  bool get isDesktop => Responsive(this).isDesktop;
}