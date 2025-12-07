import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';

import '../../core/theme/app_text_styles.dart';

import 'package:audioplayers/audioplayers.dart';


class TextSplash extends StatefulWidget {
  const TextSplash({super.key});

  @override
  State<TextSplash> createState() => _TextSplashState();
}

class _TextSplashState extends State<TextSplash> {
  final AudioPlayer _audioPlayer = AudioPlayer();

  final AnimatedTextController _controller = AnimatedTextController();


  Future<void> _startTypingSound() async {
    print('_startTypingSound  ...');
    await _audioPlayer.play(AssetSource('sounds/typing.mp3'));
  }

  Future<void> _stopTypingSound() async {
    print('_stopTypingSound');
    await _audioPlayer.stop();
    Navigator.of(context).pushNamed('/home');
  }

  @override
  void initState() {
    _startTypingSound();
    super.initState();
  }


  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: DefaultTextStyle(
          style: const TextStyle(fontSize: 30.0, fontFamily: 'Agne'),
          child: AnimatedTextKit(
            repeatForever: false,
            isRepeatingAnimation: false,
            onNext: (d, isd) {
              print("on next ${isd}");
            },
            onNextBeforePause: (d, isd) {
              print("onNextBeforePause ${d}");
            },
            onFinished: () {
              _stopTypingSound();
              print("onFinished");
            },
            controller: _controller,

            animatedTexts: [
              TypewriterAnimatedText(
                'Welcome to my world',
                speed: Duration(milliseconds: 100),
                textStyle: AppTextStyles.heroTitleResponsive(context),
              ),
              // TyperAnimatedText(
              //   'Welcome to my world 2 ',
              // ),
            ],
            onTap: () {
              print("Tap Event");
            },
          ),
        ),
      ),
    );
  }
}
