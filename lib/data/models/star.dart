enum StarColor { white, blue, cyan }

class Star {
  final double x;
  final double y;
  final double z;
  final double size;
  final StarColor color;

  Star({
    required this.x,
    required this.y,
    required this.z,
    required this.size,
    required this.color,
  });
}
