import 'package:flutter/material.dart';
import 'package:freedom_chat_app/core/helpers/extension.dart';
import 'package:freedom_chat_app/core/helpers/helper_methods.dart';
import 'package:freedom_chat_app/core/utils/sizes.dart';
import 'package:freedom_chat_app/core/utils/strings.dart';
import 'package:freedom_chat_app/core/widgets/elevated_button.dart';
import 'package:freedom_chat_app/freedom/sign_up/presentation/widgets/change_profile_image.dart';
import 'package:freedom_chat_app/freedom/sign_up/presentation/widgets/complete_your_sign_up_text_fields.dart';
import '../../../../core/routes/routes.dart';

class CompleteYourSignUpBody extends StatelessWidget {
  const CompleteYourSignUpBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const ChangeProfileImage(),
              HelperMethod.verticalSpace(AppSizes.verticalSpacingS40),
              const CompleteYourSignUpTextFieldSignUp(),
              HelperMethod.verticalSpace(AppSizes.verticalSpacingS40),
              CustomElevatedButton(
                title: AppStrings.signUp,
                onPressed: () {
                  context.pushReplacementNamed(Routes.verifyEmailPage);
                },
              ),

            ],
          ),
        ),
      ),
    );
  }
}
