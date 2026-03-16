import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';

/// A reusable wrapper that triggers a fade + slide animation
/// when the child scrolls into the viewport.
///
/// Animations fire only once (no replay on re-scroll).
class ScrollAnimateIn extends StatefulWidget {
  final Widget child;

  /// How much of the widget must be visible to trigger (0.0–1.0).
  final double visibilityThreshold;

  /// Extra delay before the animation starts (useful for staggering).
  final Duration delay;

  /// Duration of the animation.
  final Duration duration;

  /// The curve for the animation.
  final Curve curve;

  /// Starting offset for the slide (e.g., Offset(0, 0.15) = slide up).
  final Offset slideBegin;

  const ScrollAnimateIn({
    super.key,
    required this.child,
    this.visibilityThreshold = 0.15,
    this.delay = Duration.zero,
    this.duration = const Duration(milliseconds: 600),
    this.curve = Curves.easeOutCubic,
    this.slideBegin = const Offset(0, 0.15),
  });

  @override
  State<ScrollAnimateIn> createState() => _ScrollAnimateInState();
}

class _ScrollAnimateInState extends State<ScrollAnimateIn>
    with SingleTickerProviderStateMixin {
  bool _isVisible = false;
  bool _hasAnimated = false;

  // Unique key for VisibilityDetector
  late final Key _detectorKey;

  @override
  void initState() {
    super.initState();
    _detectorKey = UniqueKey();
  }

  void _onVisibilityChanged(VisibilityInfo info) {
    if (_hasAnimated) return;

    final fraction = info.visibleFraction;
    if (fraction >= widget.visibilityThreshold) {
      _hasAnimated = true;
      // Apply the stagger delay before triggering
      if (widget.delay > Duration.zero) {
        Future.delayed(widget.delay, () {
          if (mounted) setState(() => _isVisible = true);
        });
      } else {
        setState(() => _isVisible = true);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: _detectorKey,
      onVisibilityChanged: _onVisibilityChanged,
      child: AnimatedOpacity(
        opacity: _isVisible ? 1.0 : 0.0,
        duration: widget.duration,
        curve: widget.curve,
        child: AnimatedSlide(
          offset: _isVisible ? Offset.zero : widget.slideBegin,
          duration: widget.duration,
          curve: widget.curve,
          child: widget.child,
        ),
      ),
    );
  }
}
