import 'package:flutter/material.dart';
import 'package:freedom_chat_app/core/helpers/extension.dart';
import 'package:freedom_chat_app/core/helpers/helper_methods.dart';
import 'package:freedom_chat_app/core/utils/sizes.dart';
import 'package:freedom_chat_app/core/widgets/elevated_button.dart';
import 'package:freedom_chat_app/core/widgets/image_logo.dart';
import '../../../../core/routes/routes.dart';
import '../../../../core/themes/app_colors.dart';
import '../../../../core/utils/strings.dart';

class AuthBody extends StatelessWidget {
  const AuthBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.all(AppSizes.kDefaultAllPaddingS20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const ImageLogo(),
            HelperMethod.verticalSpace(AppSizes.verticalSpacingS90),
            CustomElevatedButton(
              title: AppStrings.signIn,
              onPressed: () {
                context.pushNamed(Routes.signInPage);
              },
            ),
            HelperMethod.verticalSpace(AppSizes.verticalSpacingS20),
            CustomElevatedButton(
              title: AppStrings.signUp,
              onPressed: () {
                context.pushNamed(Routes.signUpPage);
              },
              colors: AppColors.kSecondaryColor,
            ),
          ],
        ),
      ),
    );
  }
}
