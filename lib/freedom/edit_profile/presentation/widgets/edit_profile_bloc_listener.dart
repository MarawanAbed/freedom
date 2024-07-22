import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:freedom_chat_app/core/helpers/helper_methods.dart';
import 'package:freedom_chat_app/core/utils/strings.dart';
import 'package:freedom_chat_app/freedom/edit_profile/presentation/bloc/update_profile_cubit.dart';

class EditProfileBlocListener extends StatelessWidget {
  const EditProfileBlocListener({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<UpdateProfileCubit, UpdateProfileState>(
      listenWhen: (previous, current) {
        return current is Success || current is Error || current is Loading;
      },
      listener: (context, state) {
        state.whenOrNull(
          loading: () {
            HelperMethod.showLoadingDialog(context);
          },
          success: () {
            HelperMethod.showSuccessToast(
              AppStrings.profileUpdatedSuccessfully,
              gravity: ToastGravity.BOTTOM,
            );
          },
          error: (message) {
            HelperMethod.showErrorToast(message, gravity: ToastGravity.BOTTOM);
          },
        );
      },
      child: const SizedBox.shrink(),
    );
  }
}
