import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:freedom_chat_app/core/helpers/extension.dart';
import 'package:freedom_chat_app/core/helpers/helper_methods.dart';
import 'package:freedom_chat_app/core/routes/routes.dart';
import 'package:freedom_chat_app/core/utils/strings.dart';
import 'package:freedom_chat_app/freedom/sign_up/presentation/bloc/sign_up_cubit.dart';

class SignUpBlocListener extends StatelessWidget {
  const SignUpBlocListener({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignUpCubit, SignUpState>(
      listenWhen: (previous, current) =>
          current is Loading || current is Success || current is Error,
      listener: (BuildContext context, state) {
        state.whenOrNull(
          loading: () {
            HelperMethod.showLoadingDialog(context);
          },
          success: () {
            Navigator.pop(context);
            context.pushNamedAndRemoveUntil(
              Routes.verifyEmailPage, predicate: (route) => false,
            );
            HelperMethod.showSuccessToast(
              AppStrings.signUpSuccess,
              gravity: ToastGravity.BOTTOM,
            );

          },
          error: (message) {
            Navigator.pop(context);
            HelperMethod.showErrorToast(message, gravity: ToastGravity.BOTTOM);
          },
        );
      },
      child: const SizedBox.shrink(),
    );
  }
}
