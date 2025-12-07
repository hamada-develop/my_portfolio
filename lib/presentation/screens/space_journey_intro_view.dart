
import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'dart:ui' as ui;
import '../../data/models/star.dart';
import 'home_view.dart';

class SpaceJourneyIntroView extends StatefulWidget {
  const SpaceJourneyIntroView({super.key});

  @override
  State<SpaceJourneyIntroView> createState() => _SpaceJourneyIntroViewState();
}

class _SpaceJourneyIntroViewState extends State<SpaceJourneyIntroView>
    with TickerProviderStateMixin {
  late final AnimationController _buttonPulseController;
  late final AnimationController _travelController;
  late final AnimationController _shakeController;

  late final Animation<double> _speedAnimation;
  late final Animation<double> _buttonFadeOut;
  late final Animation<double> _speedIndicatorFadeOut;
  late final Animation<double> _shakeAnimation;
  late final Animation<double> _vignetteAnimation;
  late final Animation<Color?> _speedColorAnimation;
  late final Animation<Color?> _backgroundColorAnimation;

  // Star growth animations
  late final Animation<double> _starSizeAnimation;
  late final Animation<double> _starGlowAnimation;
  late final Animation<double> _starOpacityAnimation;

  JourneyState _journeyState = JourneyState.waitingToStart;

  @override
  void initState() {
    super.initState();

    _buttonPulseController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..repeat(reverse: true);

    _travelController = AnimationController(
      duration: const Duration(seconds: 6, milliseconds: 500),
      vsync: this,
    );

    _shakeController = AnimationController(
      duration: const Duration(milliseconds: 50),
      vsync: this,
    );

    _speedAnimation = CurvedAnimation(
      parent: _travelController,
      curve: Curves.easeInExpo,
    );

    _buttonFadeOut = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _travelController,
        curve: const Interval(0.0, 0.12, curve: Curves.easeOut),
      ),
    );

    _speedIndicatorFadeOut = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _travelController,
        curve: const Interval(0.85, 1.0, curve: Curves.easeOut),
      ),
    );

    _shakeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(_shakeController);

    _vignetteAnimation = Tween<double>(begin: 0.0, end: 0.7).animate(
      CurvedAnimation(
        parent: _travelController,
        curve: const Interval(0.6, 1.0, curve: Curves.easeIn),
      ),
    );

    _speedColorAnimation = ColorTween(begin: Colors.blue, end: Colors.white)
        .animate(
      CurvedAnimation(
        parent: _travelController,
        curve: const Interval(0.5, 1.0, curve: Curves.easeIn),
      ),
    );

    _backgroundColorAnimation =
        ColorTween(
          begin: const Color(0xFF0d1b2a),
          end: const Color(0xFF000000),
        ).animate(
          CurvedAnimation(parent: _travelController, curve: Curves.easeInCubic),
        );

    // Star grows from tiny dot to screen-filling
    _starSizeAnimation = Tween<double>(begin: 3.0, end: 2000.0).animate(
      CurvedAnimation(parent: _travelController, curve: Curves.easeInQuart),
    );

    // Star glow intensifies as we approach
    _starGlowAnimation = Tween<double>(begin: 20.0, end: 300.0).animate(
      CurvedAnimation(parent: _travelController, curve: Curves.easeInCubic),
    );

    // Star becomes more visible as we get closer
    _starOpacityAnimation = Tween<double>(begin: 0.3, end: 1.0).animate(
      CurvedAnimation(
        parent: _travelController,
        curve: const Interval(0.0, 0.6, curve: Curves.easeIn),
      ),
    );

    _travelController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        if (_shakeController.isAnimating) _shakeController.stop();

        setState(() {
          _journeyState = JourneyState.arrived;
        });
      }
    });

    _travelController.addListener(() {
      final speedVal = _speedAnimation.value;
      if (_journeyState == JourneyState.traveling &&
          _travelController.value >= 0.75) {
        setState(() => _journeyState = JourneyState.arriving);

        // Navigate when star is almost filling the screen
        Future.delayed(const Duration(milliseconds: 1200), () {
          Navigator.of(
            context,
          ).pushReplacement(_createCinematicRoute(const HomeView()));
        });
      }

      if (speedVal > 0.75) {
        if (!_shakeController.isAnimating) {
          _shakeController.repeat(reverse: true);
        }
      } else {
        if (_shakeController.isAnimating) _shakeController.stop();
      }
    });
  }

  PageRouteBuilder _createCinematicRoute(Widget page) {
    return PageRouteBuilder(
      transitionDuration: const Duration(milliseconds: 1500),
      reverseTransitionDuration: const Duration(milliseconds: 700),
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        // Continue the star expansion into home page
        final starExpansion = Tween<double>(begin: 2000.0, end: 5000.0).animate(
          CurvedAnimation(parent: animation, curve: Curves.easeOutCubic),
        );

        return AnimatedBuilder(
          animation: animation,
          builder: (context, _) {
            return Stack(
              fit: StackFit.expand,
              children: [
                // Continuous starfield background
                CustomPaint(
                  painter: EnhancedStarfieldPainter(
                    speed: 1.0 - animation.value,
                    time: 1.0,
                    isStatic: false,
                    backgroundColor: const Color(0xFF000000),
                  ),
                ),
                // The star continues to expand and fill
                Center(
                  child: Container(
                    width: starExpansion.value,
                    height: starExpansion.value,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: RadialGradient(
                        colors: [
                          const Color(0xFF1A0B2E),
                          const Color(0xFF1A0B2E).withOpacity(0.0),
                        ],
                        stops: const [0.4, 1.0],
                      ),
                    ),
                  ),
                ),
                // Fade in home content
                Opacity(opacity: animation.value, child: child),
              ],
            );
          },
        );
      },
    );
  }

  @override
  void dispose() {
    _buttonPulseController.dispose();
    _travelController.dispose();
    _shakeController.dispose();
    super.dispose();
  }

  void _startJourney() {
    if (_journeyState != JourneyState.waitingToStart) return;
    setState(() {
      _journeyState = JourneyState.traveling;
    });
    _travelController.forward(from: 0.0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedBuilder(
        animation: Listenable.merge([
          _travelController,
          _buttonPulseController,
          _shakeController,
        ]),
        builder: (context, child) {
          final shakeIntensity =
          (_journeyState == JourneyState.traveling &&
              _speedAnimation.value > 0.75)
              ? (_speedAnimation.value - 0.75) * 40
              : 0.0;

          final shakeX =
          (math.sin(_shakeAnimation.value * math.pi * 2) * shakeIntensity);
          final shakeY =
          (math.cos(_shakeAnimation.value * math.pi * 4) *
              shakeIntensity *
              0.5);

          return Transform.translate(
            offset: Offset(shakeX, shakeY),
            child: Stack(
              children: [
                // CONTINUOUS STARFIELD
                Positioned.fill(
                  child: CustomPaint(
                    painter: EnhancedStarfieldPainter(
                      speed: _journeyState == JourneyState.waitingToStart
                          ? 0.0
                          : _speedAnimation.value,
                      time: _travelController.value,
                      isStatic: _journeyState == JourneyState.waitingToStart,
                      backgroundColor:
                      _journeyState == JourneyState.waitingToStart
                          ? const Color(0xFF0d1b2a)
                          : (_backgroundColorAnimation.value ??
                          const Color(0xFF0d1b2a)),
                    ),
                  ),
                ),

                // THE DESTINATION STAR (0xFF1A0B2E)
                if (_journeyState == JourneyState.traveling ||
                    _journeyState == JourneyState.arriving)
                  Center(
                    child: Opacity(
                      opacity: _starOpacityAnimation.value,
                      child: Container(
                        width: _starSizeAnimation.value,
                        height: _starSizeAnimation.value,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: RadialGradient(
                            colors: [
                              const Color(0xFF1A0B2E),
                              const Color(0xFF1A0B2E).withOpacity(0.8),
                              const Color(0xFF1A0B2E).withOpacity(0.0),
                            ],
                            stops: const [0.0, 0.5, 1.0],
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFF1A0B2E).withOpacity(0.6),
                              blurRadius: _starGlowAnimation.value,
                              spreadRadius: _starGlowAnimation.value * 0.3,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                // VIGNETTE EFFECT
                if (_journeyState == JourneyState.traveling &&
                    _speedAnimation.value > 0.6)
                  Positioned.fill(
                    child: IgnorePointer(
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: RadialGradient(
                            colors: [
                              Colors.transparent,
                              Colors.black.withOpacity(
                                _vignetteAnimation.value,
                              ),
                            ],
                            stops: const [0.3, 1.0],
                          ),
                        ),
                      ),
                    ),
                  ),

                // INTRO SCREEN
                if (_journeyState == JourneyState.waitingToStart ||
                    _journeyState == JourneyState.traveling)
                  Positioned.fill(
                    child: Opacity(
                      opacity: _journeyState == JourneyState.waitingToStart
                          ? 1.0
                          : _buttonFadeOut.value,
                      child: IgnorePointer(
                        ignoring: _journeyState != JourneyState.waitingToStart,
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              TweenAnimationBuilder<double>(
                                tween: Tween(begin: -0.05, end: 0.05),
                                duration: const Duration(seconds: 2),
                                curve: Curves.easeInOut,
                                builder: (context, angle, child) {
                                  return Transform.rotate(
                                    angle: angle,
                                    child: const Icon(
                                      Icons.rocket_launch,
                                      size: 100,
                                      color: Colors.white70,
                                    ),
                                  );
                                },
                              ),
                              const SizedBox(height: 40),
                              ShaderMask(
                                shaderCallback: (bounds) => LinearGradient(
                                  colors: [
                                    Colors.blue.shade300,
                                    Colors.cyan.shade200,
                                    Colors.blue.shade300,
                                  ],
                                ).createShader(bounds),
                                child: const Text(
                                  'READY FOR LAUNCH?',
                                  style: TextStyle(
                                    fontSize: 28,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 3,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 60),
                              Transform.scale(
                                scale:
                                1.0 + (_buttonPulseController.value * 0.03),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.blue.withOpacity(0.6),
                                        blurRadius:
                                        25 +
                                            (_buttonPulseController.value * 15),
                                        spreadRadius:
                                        5 +
                                            (_buttonPulseController.value * 3),
                                      ),
                                      BoxShadow(
                                        color: Colors.cyan.withOpacity(0.4),
                                        blurRadius:
                                        40 +
                                            (_buttonPulseController.value * 20),
                                        spreadRadius: 10,
                                      ),
                                    ],
                                  ),
                                  child: ElevatedButton(
                                    onPressed: _startJourney,
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.blue.shade700,
                                      foregroundColor: Colors.white,
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 50,
                                        vertical: 22,
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(50),
                                      ),
                                      elevation: 12,
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: const [
                                        Icon(
                                          Icons.airline_seat_recline_normal,
                                          size: 30,
                                        ),
                                        SizedBox(width: 15),
                                        Text(
                                          'FASTEN SEATBELT',
                                          style: TextStyle(
                                            fontSize: 22,
                                            fontWeight: FontWeight.bold,
                                            letterSpacing: 2,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 25),
                              TweenAnimationBuilder<double>(
                                tween: Tween(begin: 0.0, end: 1.0),
                                duration: const Duration(seconds: 2),
                                curve: Curves.easeInOut,
                                builder: (context, opacity, child) {
                                  return Opacity(
                                    opacity: opacity * 0.6,
                                    child: Text(
                                      'Tap to begin your journey',
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.white.withOpacity(0.6),
                                        letterSpacing: 1.2,
                                        fontStyle: FontStyle.italic,
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),

                // SPEED INDICATOR
                if (_journeyState == JourneyState.traveling ||
                    _journeyState == JourneyState.arriving)
                  Positioned(
                    bottom: 60,
                    left: 0,
                    right: 0,
                    child: Opacity(
                      opacity: _speedIndicatorFadeOut.value,
                      child: Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            ShaderMask(
                              shaderCallback: (bounds) => LinearGradient(
                                colors: [
                                  _speedColorAnimation.value ?? Colors.blue,
                                  _speedColorAnimation.value?.withOpacity(
                                    0.8,
                                  ) ??
                                      Colors.blue,
                                ],
                              ).createShader(bounds),
                              child: Text(
                                'SPEED: ${(_speedAnimation.value * 100).toInt()}%',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 4,
                                ),
                              ),
                            ),
                            const SizedBox(height: 12),
                            Container(
                              width: 250,
                              height: 6,
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(3),
                              ),
                              child: FractionallySizedBox(
                                alignment: Alignment.centerLeft,
                                widthFactor: _speedAnimation.value.clamp(
                                  0.0,
                                  1.0,
                                ),
                                child: Container(
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [
                                        Colors.blue,
                                        Colors.cyan,
                                        if (_speedAnimation.value > 0.7)
                                          Colors.white,
                                      ],
                                    ),
                                    borderRadius: BorderRadius.circular(3),
                                    boxShadow: [
                                      BoxShadow(
                                        color:
                                        (_speedColorAnimation.value ??
                                            Colors.blue)
                                            .withOpacity(0.8),
                                        blurRadius: 10,
                                        spreadRadius: 2,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 12),
                            Text(
                              'LIGHT SPEED',
                              style: TextStyle(
                                color:
                                (_speedColorAnimation.value ?? Colors.blue)
                                    .withOpacity(0.7),
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                letterSpacing: 3,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}

enum JourneyState { waitingToStart, traveling, arriving, arrived }

class EnhancedStarfieldPainter extends CustomPainter {
  final double speed;
  final double time;
  final bool isStatic;
  final Color backgroundColor;

  static final List<Star> _stars = _generateStars();
  static const int starCount = 400;

  EnhancedStarfieldPainter({
    required this.speed,
    required this.time,
    this.isStatic = false,
    this.backgroundColor = const Color(0xFF0d1b2a),
  });

  static List<Star> _generateStars() {
    final random = math.Random(42);
    return List<Star>.generate(starCount, (_) {
      final x = random.nextDouble() * 2 - 1;
      final y = random.nextDouble() * 2 - 1;
      final z = random.nextDouble();
      final size = random.nextDouble() * 2.5 + 0.5;
      final color = random.nextDouble() > 0.95
          ? StarColor.blue
          : random.nextDouble() > 0.9
          ? StarColor.cyan
          : StarColor.white;
      return Star(x: x, y: y, z: z, size: size, color: color);
    });
  }

  @override
  void paint(Canvas canvas, Size size) {
    final centerX = size.width / 2;
    final centerY = size.height / 2;

    // Smooth gradient background
    final rect = Rect.fromLTWH(0, 0, size.width, size.height);
    final gradient = RadialGradient(
      center: Alignment.center,
      radius: 1.2,
      colors: [
        backgroundColor,
        Color.lerp(backgroundColor, Colors.black, 0.5)!,
        Colors.black,
      ],
      stops: const [0.0, 0.5, 1.0],
    );
    final paint = Paint()..shader = gradient.createShader(rect);
    canvas.drawRect(rect, paint);

    if (isStatic) {
      final random = math.Random(42);
      for (int i = 0; i < 200; i++) {
        final x = random.nextDouble() * size.width;
        final y = random.nextDouble() * size.height;
        final starSize = random.nextDouble() * 2.5;
        final opacity = 0.5 + random.nextDouble() * 0.5;

        final starColor = random.nextDouble() > 0.95
            ? Colors.blue
            : random.nextDouble() > 0.9
            ? Colors.cyan.shade300
            : Colors.white;

        final starPaint = Paint()
          ..color = starColor.withOpacity(opacity)
          ..style = PaintingStyle.fill;

        canvas.drawCircle(Offset(x, y), starSize, starPaint);

        if (starSize > 1.5) {
          final glowPaint = Paint()
            ..color = starColor.withOpacity(opacity * 0.3)
            ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 3);
          canvas.drawCircle(Offset(x, y), starSize * 2, glowPaint);
        }
      }
      return;
    }

    // Animated stars with constant brightness
    for (final star in _stars) {
      final speedFactor = 1 + speed * 60;
      final z = (star.z - time * speedFactor * 0.5) % 1.0;
      if (z <= 0) continue;

      final scale = (1 - z);
      final x = centerX + (star.x / z) * centerX * scale;
      final y = centerY + (star.y / z) * centerY * scale;

      final trailLength = speed * 60 * scale;
      final brightness = (1 - z) * 0.8;

      final starColor = star.color == StarColor.blue
          ? Colors.lightBlue
          : star.color == StarColor.cyan
          ? Colors.cyan
          : Colors.white;

      // Star trails
      if (trailLength > 2) {
        final dx = (star.x / z) * centerX * scale;
        final dy = (star.y / z) * centerY * scale;
        final trailX = x - dx * trailLength * 0.025;
        final trailY = y - dy * trailLength * 0.025;

        final trailPaint = Paint()
          ..shader = ui.Gradient.linear(Offset(trailX, trailY), Offset(x, y), [
            starColor.withOpacity(0),
            starColor.withOpacity(brightness * 0.7),
          ])
          ..strokeWidth = star.size * scale * 0.6
          ..strokeCap = StrokeCap.round;

        canvas.drawLine(Offset(trailX, trailY), Offset(x, y), trailPaint);
      }

      // Draw star with consistent glow
      final starPaint = Paint()
        ..color = starColor.withOpacity(brightness)
        ..style = PaintingStyle.fill;

      canvas.drawCircle(Offset(x, y), star.size * scale, starPaint);

      if (scale > 0.5) {
        final glowPaint = Paint()
          ..color = starColor.withOpacity(brightness * 0.4)
          ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 4);
        canvas.drawCircle(Offset(x, y), star.size * scale * 2, glowPaint);
      }
    }

    // Warp streaks
    if (speed > 0.65) {
      final random = math.Random((time * 1000).toInt());
      final streakIntensity = (speed - 0.65) * 2;

      for (int i = 0; i < 30; i++) {
        final angle = random.nextDouble() * math.pi * 2;
        final distance = random.nextDouble() * size.width * 0.45;
        final x1 = centerX + math.cos(angle) * distance;
        final y1 = centerY + math.sin(angle) * distance;
        final length = 80 + speed * 100;
        final x2 = centerX + math.cos(angle) * (distance + length);
        final y2 = centerY + math.sin(angle) * (distance + length);

        final streakPaint = Paint()
          ..shader = ui.Gradient.linear(
            Offset(x1, y1),
            Offset(x2, y2),
            [
              Colors.transparent,
              Colors.cyan.withOpacity(streakIntensity * 0.4),
              Colors.white.withOpacity(streakIntensity * 0.6),
            ],
            [0.0, 0.5, 1.0],
          )
          ..strokeWidth = 1.5
          ..strokeCap = StrokeCap.round;

        canvas.drawLine(Offset(x1, y1), Offset(x2, y2), streakPaint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant EnhancedStarfieldPainter oldDelegate) {
    return oldDelegate.speed != speed ||
        oldDelegate.time != time ||
        oldDelegate.isStatic != isStatic ||
        oldDelegate.backgroundColor != backgroundColor;
  }
}

