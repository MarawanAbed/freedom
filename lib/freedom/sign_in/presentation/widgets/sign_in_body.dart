import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freedom_chat_app/core/helpers/helper_methods.dart';
import 'package:freedom_chat_app/core/routes/routes.dart';
import 'package:freedom_chat_app/core/themes/styles.dart';
import 'package:freedom_chat_app/core/utils/sizes.dart';
import 'package:freedom_chat_app/core/utils/strings.dart';
import 'package:freedom_chat_app/core/widgets/elevated_button.dart';
import 'package:freedom_chat_app/core/widgets/image_logo.dart';
import 'package:freedom_chat_app/core/widgets/text_navigate.dart';
import 'package:freedom_chat_app/freedom/sign_in/presentation/bloc/sign_in_cubit.dart';
import 'package:freedom_chat_app/freedom/sign_in/presentation/widgets/build_row_logo.dart';
import 'package:freedom_chat_app/freedom/sign_in/presentation/widgets/email_and_password_text_fields_sign_in.dart';
import 'package:freedom_chat_app/freedom/sign_in/presentation/widgets/sign_in_bloc_listener.dart';

class SignInBody extends StatelessWidget {
  const SignInBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(AppSizes.kDefaultAllPaddingS20),
      child: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const ImageLogo(),
              HelperMethod.verticalSpace(AppSizes.verticalSpacingS100),
              const EmailAndPasswordTextFieldsSignIn(),
              HelperMethod.verticalSpace(AppSizes.verticalSpacingS30),
              CustomElevatedButton(
                title: AppStrings.signIn,
                onPressed: () async {
                  if (context
                      .read<SignInCubit>()
                      .formKey
                      .currentState!
                      .validate()) {
                    await context
                        .read<SignInCubit>()
                        .signInWithEmailAndPassword();
                  }
                },
              ),
              HelperMethod.verticalSpace(AppSizes.verticalSpacingS30),
              const TextNavigate(
                title: AppStrings.forgetPassword,
                route: Routes.forgotPasswordPage,
              ),
              HelperMethod.verticalSpace(AppSizes.verticalSpacingS30),
              const TextNavigate(
                title: AppStrings.dontHaveAccount,
                subTitle: AppStrings.signUp,
                route: Routes.signUpPage,
              ),
              const Divider(
                color: Colors.grey,
              ),
              HelperMethod.verticalSpace(AppSizes.verticalSpacingS10),
              Text(
                AppStrings.orSignInWith,
                style: TextStyles.font16NormalGrey,
              ),
              HelperMethod.verticalSpace(AppSizes.verticalSpacingS10),
              const BuildRowLogo(),
              const SignInBlocListener(),
            ],
          ),
        ),
      ),
    );
  }
}
