import 'package:flutter/animation.dart';

class OffsetAnimation extends CurvedAnimation {
  OffsetAnimation({required super.parent})
    : super(
        curve: const Interval(
          2 / 5,
          3 / 5,
          curve: Curves.easeInOutCubicEmphasized,
        ),
        reverseCurve: Interval(
          4 / 5,
          1,
          curve: Curves.easeInOutCubicEmphasized.flipped,
        ),
      );
}

class RailAnimation extends CurvedAnimation {
  RailAnimation({required super.parent})
    : super(
        curve: const Interval(0 / 5, 4 / 5),
        reverseCurve: const Interval(3 / 5, 1),
      );
}

class SizeAnimation extends CurvedAnimation {
  SizeAnimation({required super.parent})
    : super(
        curve: const Interval(
          0 / 5,
          3 / 5,
          curve: Curves.easeInOutCubicEmphasized,
        ),
        reverseCurve: Interval(
          2 / 5,
          1,
          curve: Curves.easeInOutCubicEmphasized.flipped,
        ),
      );
}
