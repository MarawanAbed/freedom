import 'package:flutter/material.dart';
import 'package:freedom_chat_app/freedom/onBoarding/presentation/widgets/build_skip_button.dart';
import 'package:freedom_chat_app/freedom/onBoarding/presentation/widgets/build_welcome_image.dart';
import 'package:freedom_chat_app/freedom/onBoarding/presentation/widgets/build_welcome_text.dart';
class OnBoardingBody extends StatelessWidget {
  const OnBoardingBody({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Column(
        children: [
          Spacer(flex: 2),
          BuildWelcomeImage(),
          Spacer(flex: 2),
          BuildWelcomeText(),
          Spacer(flex: 1),
          Spacer(flex: 4),
          BuildSkipButton(),
        ],
      ),
    );
  }
}
