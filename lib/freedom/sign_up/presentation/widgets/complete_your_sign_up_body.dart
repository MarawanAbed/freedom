import 'package:flutter/material.dart';
import 'package:freedom_chat_app/core/helpers/helper_methods.dart';
import 'package:freedom_chat_app/core/utils/sizes.dart';
import 'package:freedom_chat_app/core/utils/strings.dart';
import 'package:freedom_chat_app/core/widgets/elevated_button.dart';
import 'package:freedom_chat_app/freedom/sign_up/presentation/bloc/sign_up_cubit.dart';
import 'package:freedom_chat_app/freedom/sign_up/presentation/widgets/change_profile_image.dart';
import 'package:freedom_chat_app/freedom/sign_up/presentation/widgets/complete_your_sign_up_text_fields.dart';
import 'package:freedom_chat_app/freedom/sign_up/presentation/widgets/sign_up_bloc_listener.dart';

class CompleteYourSignUpBody extends StatelessWidget {
  const CompleteYourSignUpBody({super.key, required this.cubit});

  final SignUpCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              ChangeProfileImage(
                cubit: cubit,
              ),
              HelperMethod.verticalSpace(AppSizes.verticalSpacingS40),
              CompleteYourSignUpTextFieldSignUp(
                cubit: cubit,
              ),
              HelperMethod.verticalSpace(AppSizes.verticalSpacingS40),
              CustomElevatedButton(
                title: AppStrings.signUp,
                onPressed: () async {
                  if (cubit.profileImage != null) {
                    if (cubit.formKey.currentState!.validate()) {
                       cubit.uploadImage(context).then((_)async
                       {
                         await cubit.signUp();
                       });
                    } else {
                      HelperMethod.showErrorToast('Please fill all fields');
                    }
                  } else {
                    HelperMethod.showErrorToast(
                        'Please select a profile image');
                  }
                },
              ),
              const SignUpBlocListener(),
            ],
          ),
        ),
      ),
    );
  }
}
