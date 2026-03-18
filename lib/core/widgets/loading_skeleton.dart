import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

/// A premium, beautiful loading screen that replaces the standard top-bar
/// with a centered, animated brand experience.
class LoadingScreen extends StatelessWidget {
  const LoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Premium deep purple gradient background
    const backgroundColor = Color(0xFF0D051A);
    const accentColor = Color(0xFFD5BBFC);

    return Scaffold(
      backgroundColor: backgroundColor,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: RadialGradient(
            center: Alignment.center,
            radius: 0.8,
            colors: [
              Color(0xFF1A0B2E),
              Color(0xFF0D051A),
            ],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Centered branding icon with pulse and rotation
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: accentColor.withOpacity(0.05),
                  border: Border.all(
                    color: accentColor.withOpacity(0.1),
                    width: 2,
                  ),
                ),
                child: const Icon(
                  Icons.code_rounded,
                  size: 64,
                  color: accentColor,
                ),
              )
                  .animate(onPlay: (controller) => controller.repeat())
                  .shimmer(
                    duration: 2000.ms,
                    color: accentColor.withOpacity(0.3),
                  )
                  .scale(
                    begin: const Offset(0.9, 0.9),
                    end: const Offset(1.1, 1.1),
                    duration: 1000.ms,
                    curve: Curves.easeInOut,
                  )
                  .then()
                  .scale(
                    begin: const Offset(1.1, 1.1),
                    end: const Offset(0.9, 0.9),
                    duration: 1000.ms,
                    curve: Curves.easeInOut,
                  ),
              const SizedBox(height: 32),
              // Elegant loading text
              Text(
                'HAMADA MOHAMED SEIF',
                style: TextStyle(
                  color: accentColor.withOpacity(0.9),
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 4,
                ),
              )
                  .animate()
                  .fadeIn(duration: 800.ms)
                  .slideY(begin: 0.2, end: 0),
              const SizedBox(height: 8),
              Text(
                'BUILDING DIGITAL EXPERIENCES',
                style: TextStyle(
                  color: accentColor.withOpacity(0.4),
                  fontSize: 10,
                  fontWeight: FontWeight.w400,
                  letterSpacing: 2,
                ),
              )
                  .animate()
                  .fadeIn(delay: 400.ms, duration: 800.ms),
              const SizedBox(height: 48),
              // Subtle loading indicator at the bottom
              SizedBox(
                width: 40,
                child: LinearProgressIndicator(
                  backgroundColor: accentColor.withOpacity(0.1),
                  valueColor: AlwaysStoppedAnimation<Color>(
                    accentColor.withOpacity(0.5),
                  ),
                  borderRadius: BorderRadius.circular(10),
                  minHeight: 2,
                ),
              )
                  .animate(onPlay: (controller) => controller.repeat())
                  .shimmer(duration: 1500.ms, color: accentColor),
            ],
          ),
        ),
      ),
    );
  }
}
