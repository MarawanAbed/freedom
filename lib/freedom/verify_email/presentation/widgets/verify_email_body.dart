import 'package:flutter/material.dart';
import 'package:freedom_chat_app/core/helpers/helper_methods.dart';
import 'package:freedom_chat_app/core/themes/app_colors.dart';
import 'package:freedom_chat_app/core/utils/sizes.dart';
import 'package:freedom_chat_app/core/utils/strings.dart';
import 'package:freedom_chat_app/core/widgets/elevated_button.dart';
import 'package:freedom_chat_app/core/widgets/image_logo.dart';

import 'verify_email_text.dart';

class VerifyEmailBody extends StatelessWidget {
  const VerifyEmailBody({super.key});

  @override
  Widget build(BuildContext context) {
    return  SafeArea(
      child: Padding(
        padding: EdgeInsets.all(AppSizes.kDefaultAllPaddingS20),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                HelperMethod.verticalSpace(AppSizes.verticalSpacingS40),
                const ImageLogo(),
                HelperMethod.verticalSpace(AppSizes.verticalSpacingS100),
                const VerifyEmailTexts(),
                HelperMethod.verticalSpace(AppSizes.verticalSpacingS100),
                CustomElevatedButton(
                  title: AppStrings.cancel,
                  colors: AppColors.kSecondaryColor,
                  onPressed: () {
                    // cubit.logOutMethod();
                  },
                ),
                // const VerifyEmailBlocListener(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
