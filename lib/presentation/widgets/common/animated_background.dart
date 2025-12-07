import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';

class AnimatedBackground extends StatelessWidget {
  final Widget child;

  const AnimatedBackground({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: AppColors.backgroundGradient,
      ),
      child: Stack(
        children: [
          // Animated orbs
          const Positioned(
            top: 100,
            left: 100,
            child: _FloatingOrb(
              color: AppColors.primaryPurple,
              size: 400,
              duration: Duration(seconds: 3),
            ),
          ),
          const Positioned(
            bottom: 100,
            right: 100,
            child: _FloatingOrb(
              color: AppColors.primaryBlue,
              size: 400,
              duration: Duration(seconds: 4),
              delay: Duration(seconds: 1),
            ),
          ),
          const Positioned(
            top: 300,
            right: 200,
            child: _FloatingOrb(
              color: AppColors.primaryCyan,
              size: 300,
              duration: Duration(seconds: 5),
              delay: Duration(milliseconds: 1500),
            ),
          ),
          // Content
          child,
        ],
      ),
    );
  }
}

class _FloatingOrb extends StatefulWidget {
  final Color color;
  final double size;
  final Duration duration;
  final Duration delay;

  const _FloatingOrb({
    Key? key,
    required this.color,
    required this.size,
    required this.duration,
    this.delay = Duration.zero,
  }) : super(key: key);

  @override
  State<_FloatingOrb> createState() => _FloatingOrbState();
}

class _FloatingOrbState extends State<_FloatingOrb>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    );

    _animation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    Future.delayed(widget.delay, () {
      if (mounted) {
        _controller.repeat(reverse: true);
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, _animation.value * 20),
          child: Container(
            width: widget.size,
            height: widget.size,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [
                  widget.color.withOpacity(0.2),
                  widget.color.withOpacity(0.0),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

// Section background with gradient
class SectionBackground extends StatelessWidget {
  final Widget child;
  final Gradient? gradient;
  final Color? color;

  const SectionBackground({
    super.key,
    required this.child,
    this.gradient,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: gradient,
        color: color,
      ),
      child: child,
    );
  }
}