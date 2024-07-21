import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:freedom_chat_app/core/helpers/extension.dart';
import 'package:freedom_chat_app/core/routes/routes.dart';
import 'package:freedom_chat_app/core/utils/strings.dart';
import 'package:freedom_chat_app/freedom/sign_in/presentation/bloc/sign_in_cubit.dart';
import '../../../../core/helpers/helper_methods.dart';

class SignInBlocListener extends StatelessWidget {
  const SignInBlocListener({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignInCubit, SignInState>(
      listenWhen: (previous, current) =>
      current is Loading ||
          current is Success ||
          current is Error ||
          current is SuccessWithGitHub ||
          current is ErrorWithGitHub,
      listener: (context, state) {
        state.whenOrNull(
          loading: () async {
            HelperMethod.showLoadingDialog(context);
          },
          success: () async {
            Navigator.pop(context);
            HelperMethod.showSuccessToast(
              AppStrings.signInSuccess,
              gravity: ToastGravity.BOTTOM,
            );
            context.pushNamedAndRemoveUntil(Routes.homeLayout, predicate: (route) => false);
          },
          successWithGitHub: () {
            HelperMethod.showSuccessToast(
              AppStrings.signInSuccess,
              gravity: ToastGravity.BOTTOM,
            );
            context.pushNamedAndRemoveUntil(Routes.homeLayout, predicate: (route) => false);
          },
          errorWithGitHub: (message) {
            HelperMethod.showErrorToast(message, gravity: ToastGravity.BOTTOM);
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