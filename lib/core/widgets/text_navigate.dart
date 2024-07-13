import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:freedom_chat_app/core/helpers/extension.dart';
import 'package:freedom_chat_app/core/themes/styles.dart';

import '../../../core/themes/app_colors.dart';

class TextNavigate extends StatelessWidget {
  const TextNavigate(
      {super.key, required this.title, required this.route, this.subTitle});

  final String title;
  final String route;
  final String? subTitle;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        RichText(
          text: TextSpan(
            text: title,
            style: TextStyles.font16NormalGrey.copyWith(
              color:
                  subTitle == null ? AppColors.kPrimaryColorWithOpacity : null,
            ),
            children: [
              TextSpan(
                text: subTitle,
                style: TextStyles.font16NormalGrey.copyWith(
                  color: AppColors.kPrimaryColorWithOpacity,
                ),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    context.pushNamed(route);
                  },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
