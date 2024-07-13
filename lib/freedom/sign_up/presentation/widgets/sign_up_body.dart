import 'package:flutter/material.dart';
import 'package:freedom_chat_app/core/helpers/extension.dart';
import 'package:freedom_chat_app/core/helpers/helper_methods.dart';
import 'package:freedom_chat_app/core/routes/routes.dart';
import 'package:freedom_chat_app/core/utils/sizes.dart';
import 'package:freedom_chat_app/core/utils/strings.dart';
import 'package:freedom_chat_app/core/widgets/elevated_button.dart';
import 'package:freedom_chat_app/core/widgets/image_logo.dart';
import 'package:freedom_chat_app/core/widgets/text_navigate.dart';
import 'package:freedom_chat_app/freedom/sign_up/presentation/widgets/email_and_password_text_fields_sign_up.dart';

class SignUpBody extends StatelessWidget {
  const SignUpBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.all(AppSizes.kDefaultAllPaddingS20),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                HelperMethod.verticalSpace(AppSizes.verticalSpacingS20),
                const ImageLogo(),
                HelperMethod.verticalSpace(AppSizes.verticalSpacingS80),
                const EmailAndPasswordTextFieldsSignUp(),
                HelperMethod.verticalSpace(AppSizes.verticalSpacingS30),
                CustomElevatedButton(
                  title: AppStrings.completeYourSignUp,
                  onPressed: () {
                    context.pushReplacementNamed(Routes.completeYourSignUpPage);
                  },
                ),
                HelperMethod.verticalSpace(AppSizes.verticalSpacingS30),
                const TextNavigate(
                  title: AppStrings.alreadyHaveAccount,
                  route: Routes.signInPage,
                  subTitle: AppStrings.signIn,
                ),
                // const RegisterBlocListener(),
              ],
            ),
          ),
        ),
      ),
    );
  }

}
