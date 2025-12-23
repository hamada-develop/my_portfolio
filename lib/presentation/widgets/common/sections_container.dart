import 'package:flutter/material.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/utils/responsive.dart';

class SectionContainer extends StatelessWidget {
  final Widget child;
  final EdgeInsets? padding;
  final double? maxWidth;
  final Color? backgroundColor;
  final String? id;

  const SectionContainer({
    super.key,
    required this.child,
    this.padding,
    this.maxWidth,
    this.backgroundColor,
    this.id,
  });

  @override
  Widget build(BuildContext context) {
    final responsive = context.responsive;
    return Container(
      padding: padding ?? responsive.pagePadding,
      child: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: maxWidth ?? responsive.maxContentWidth,
            minHeight: responsive.height,
          ),
          child: child,
        ),
      ),
    );
  }
}

// Section with title
class SectionWithTitle extends StatelessWidget {
  final String title;
  final String? subtitle;
  final Widget child;
  final EdgeInsets? padding;
  final double? maxWidth;

  const SectionWithTitle({
    super.key,
    required this.title,
    this.subtitle,
    required this.child,
    this.padding,
    this.maxWidth,
  });

  @override
  Widget build(BuildContext context) {
    return SectionContainer(
      padding: padding,
      maxWidth: maxWidth,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SectionTitle(title: title, subtitle: subtitle),
          const SizedBox(height: AppConstants.spacing3xl),
          child,
        ],
      ),
    );
  }
}

// Section title widget
class SectionTitle extends StatelessWidget {
  final String title;
  final String? subtitle;
  final TextAlign? textAlign;

  const SectionTitle({
    Key? key,
    required this.title,
    this.subtitle,
    this.textAlign,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: textAlign == TextAlign.center
          ? CrossAxisAlignment.center
          : CrossAxisAlignment.start,
      children: [
        ShaderMask(
          blendMode: BlendMode.srcIn,
          shaderCallback: (bounds) => const LinearGradient(
            colors: [Color(0xFFA78BFA), Color(0xFF22D3EE)],
          ).createShader(bounds),
          child: Text(
            title,
            style: Theme.of(context).textTheme.displayMedium,
            textAlign: textAlign ?? TextAlign.start,
          ),
        ),
        if (subtitle != null) ...[
          const SizedBox(height: AppConstants.spacingMd),
          Text(
            subtitle!,
            style: Theme.of(
              context,
            ).textTheme.bodyLarge?.copyWith(color: const Color(0xFF9CA3AF)),
            textAlign: textAlign ?? TextAlign.start,
          ),
        ],
      ],
    );
  }
}
