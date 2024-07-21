import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:freedom_chat_app/core/di/dependancy_injection.dart';
import 'package:freedom_chat_app/core/helpers/extension.dart';
import 'package:freedom_chat_app/core/helpers/helper_methods.dart';
import 'package:freedom_chat_app/core/routes/routes.dart';
import 'package:freedom_chat_app/core/services/firebase_services.dart';
import 'package:freedom_chat_app/core/themes/app_colors.dart';
import 'package:freedom_chat_app/core/utils/sizes.dart';
import 'package:freedom_chat_app/core/utils/strings.dart';
import 'package:freedom_chat_app/core/widgets/elevated_button.dart';
import 'package:freedom_chat_app/core/widgets/image_logo.dart';
import 'package:freedom_chat_app/freedom/verify_email/domain/repositories/repo.dart';
import 'package:freedom_chat_app/freedom/verify_email/domain/use_cases/send_email_verification.dart';
import 'package:freedom_chat_app/freedom/verify_email/domain/use_cases/sign_out.dart';

import 'verify_email_text.dart';

class VerifyEmailBody extends StatefulWidget {
  const VerifyEmailBody({super.key});

  @override
  State<VerifyEmailBody> createState() => _VerifyEmailBodyState();
}

class _VerifyEmailBodyState extends State<VerifyEmailBody> {
  bool isEmailVerified = false;
  bool canResendEmail = false;
  Timer? timer;

  @override
  void initState() {
    super.initState();
    isEmailVerified = getIt<VerifyRepository>().isEmailVerified();

    if (!isEmailVerified) {
      sendVerificationEmail();
      timer = Timer.periodic(
        const Duration(seconds: 3),
        (_) => checkEmailVerified(),
      );
    }
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  Future sendVerificationEmail() async {
    try {
      await getIt<SendEmailVerificationUseCase>().call();
      HelperMethod.showSuccessToast('Email verification sent',gravity: ToastGravity.BOTTOM);
      if (mounted) {
        setState(() {
          canResendEmail = false;
        });
      }
      await Future.delayed(const Duration(minutes: 5));
      if (mounted) {
        setState(() {
          canResendEmail = true;
        });
      }
    } catch (e) {
      if (mounted) {
        showError('An error occurred while sending email verification');
      }
    }
  }

  Future checkEmailVerified() async {
    await getIt<AuthService>().auth.currentUser!.reload();
    setState(() {
      isEmailVerified = getIt<VerifyRepository>().isEmailVerified();
    });

    if (isEmailVerified) {
      timer?.cancel();
      context.pushNamedAndRemoveUntil(Routes.signInPage,
          predicate: (route) => false);
    }
  }

  void showError(String message) {
    if (mounted) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(message)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
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
                  title: AppStrings.resendEmail,
                  colors: AppColors.kPrimaryColor,
                  onPressed: canResendEmail ? sendVerificationEmail : null,
                ),
                HelperMethod.verticalSpace(AppSizes.verticalSpacingS60),
                CustomElevatedButton(
                  title: AppStrings.cancel,
                  colors: AppColors.kSecondaryColor,
                  onPressed: () async {
                    getIt<SignOutUseCase>().call();
                    context.pushNamedAndRemoveUntil(Routes.authPage,
                        predicate: (route) => false);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
