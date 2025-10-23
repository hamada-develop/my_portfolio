import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:math' as math;

class MeWidget extends StatelessWidget {
  const MeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Align(
      alignment: AlignmentDirectional.bottomStart,
      child: Container(
        width: 900,
        margin: EdgeInsets.all(100),
        height: 430,
        child: Stack(
          children: [
            Row(
              children: [
                _buildImage(),
                Column(
                  mainAxisAlignment: .center,
                  crossAxisAlignment: .baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: [
                    Text(
                      'A Designer who',
                      style: GoogleFonts.preahvihear(
                        letterSpacing: 0.2,
                        color: Colors.white,
                        fontSize: 17,
                        decoration: TextDecoration.underline,
                        decorationColor: Colors.white,
                      ),
                    ),
                    Stack(
                      children: [
                        RichText(
                          text: TextSpan(
                            text: 'Judges a book \nby its ',
                            style: GoogleFonts.preahvihear(
                              letterSpacing: 0.2,
                              fontSize: 50,
                              height: 1.3,
                              color: Colors.white,
                            ),
                            children: [
                              TextSpan(
                                text: 'Cover',
                                style: GoogleFonts.preahvihear(
                                  fontSize: 48,
                                  color: Color(0xFF7127BA),
                                ),
                              ),
                              TextSpan(text: '...\n'),
                              TextSpan(
                                text:
                                    'Because if the cover does not impress you what else can?',
                                style: GoogleFonts.preahvihear(
                                  fontSize: 11,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                        PositionedDirectional(
                          bottom: 25,
                          end: 50,
                          child: Transform.rotate(
                            // angle: -0.14,
                            angle: -0.11,
                            alignment: AlignmentDirectional.bottomCenter,
                            child: SvgPicture.asset(
                              'assets/cover.svg',
                              fit: BoxFit.cover,
                              height: 62,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            Align(
              alignment: AlignmentDirectional.topCenter,
              child: Padding(
                padding: const EdgeInsets.only(right: 70),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: .baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Transform.rotate(
                        angle: 148,
                        child: SvgPicture.asset(
                          'assets/Arrow.svg',
                          height: 81,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    _buildText(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildText() {
    return RichText(
      text: TextSpan(
        text: 'Hello! I Am ',
        style: GoogleFonts.preahvihear(color: Colors.white, fontSize: 19),
        children: [
          TextSpan(
            text: 'Hamada Mohamed',
            style: GoogleFonts.preahvihear(
              color: Color(0xFF7127BA),
              fontSize: 19,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImage() {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: 385,
          height: 431,
          decoration: const BoxDecoration(
            gradient: RadialGradient(
              center: Alignment.center,
              radius: 0.5,
              focal: Alignment.center,
              focalRadius: 0.0,
              colors: [Color(0xFF763CAC), Color(0x00320F85)],
              stops: [0.0, 1.0],
            ),
          ),
          child: ClipPath(
            clipper: _EllipseClipper(),
            child: Container(
              decoration: const BoxDecoration(
                gradient: RadialGradient(
                  center: Alignment.center,
                  colors: [Color(0xFF763CAC), Color(0x00320F85)],
                ),
              ),
            ),
          ),
        ),
        Container(
          height: 250,
          width: 250,
          decoration: BoxDecoration(
            gradient: RadialGradient(
              center: Alignment.center,
              radius: 0.5,
              stops: [0.1771, 1.0],
              colors: [Color(0xFFFFFFFF), Color(0x00434343)],
            ),
            shape: BoxShape.circle,
          ),
        ),
        Image.asset('assets/me.png', height: 223, width: 165),
      ],
    );
  }
}

class _EllipseClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    return Path()..addOval(Rect.fromLTWH(0, 0, size.width, size.height));
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
