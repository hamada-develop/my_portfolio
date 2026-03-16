import 'package:flutter/material.dart';

/// A loading screen with a centered linear progress bar — the standard
/// web-style pattern used by top sites (YouTube, GitHub, etc.).
class LoadingScreen extends StatelessWidget {
  const LoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Use the app's deep-purple background so the transition is seamless
    const backgroundColor = Color(0xFF1A0B2E);
    const accentColor = Color(0xFFD5BBFC); // primary purple from theme

    return Scaffold(
      backgroundColor: backgroundColor,
      body: Column(
        children: [
          // Top progress bar — thin, animated, sits flush at the top
          const LinearProgressIndicator(
            minHeight: 3,
            backgroundColor: Color(0xFF2C292F),
            valueColor: AlwaysStoppedAnimation<Color>(accentColor),
          ),
          const Spacer(),
          // Optional subtle branding in the center
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.code_rounded,
                size: 48,
                color: accentColor.withValues(alpha: 0.6),
              ),
              const SizedBox(height: 16),
              Text(
                'Loading...',
                style: TextStyle(
                  color: accentColor.withValues(alpha: 0.5),
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 1.2,
                ),
              ),
            ],
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
