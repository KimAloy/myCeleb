import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';

class MyTextAnimation extends StatelessWidget {
  const MyTextAnimation({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.blue,
      width: 110.0,
      child: DefaultTextStyle(
        style: const TextStyle(
          fontSize: 30.0,
          fontFamily: 'Agne',
        ),
        child: AnimatedTextKit(
          repeatForever: true,
          animatedTexts: [
            TypewriterAnimatedText(
              'Celeeb',
              textStyle: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
              speed: Duration(milliseconds: 200),
            ),
          ],
          // onTap: () {
          //   print("Tap Event");
          // },
        ),
      ),
    );
  }
}
