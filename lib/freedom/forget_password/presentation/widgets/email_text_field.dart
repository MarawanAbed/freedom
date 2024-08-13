import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freedom_chat_app/core/themes/styles.dart';
import 'package:freedom_chat_app/core/utils/sizes.dart';
import 'package:freedom_chat_app/core/utils/strings.dart';
import 'package:freedom_chat_app/freedom/forget_password/presentation/bloc/forget_password_cubit.dart';
import '../../../../../core/helpers/helper_methods.dart';
import '../../../../../core/themes/app_colors.dart';
import '../../../../../core/widgets/app_text_form.dart';
import '../../../../../core/widgets/elevated_button.dart';

class EmailTextFieldAndButton extends StatefulWidget {
  const EmailTextFieldAndButton({super.key});

  @override
  State<EmailTextFieldAndButton> createState() =>
      _EmailTextFieldAndButtonState();
}

class _EmailTextFieldAndButtonState extends State<EmailTextFieldAndButton> {
  late TextEditingController emailController;

  @override
  void initState() {
    emailController = TextEditingController();
    super.initState();
  }
  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context).brightness == Brightness.dark;
    return Column(
      children: [
        AppTextFormField(
          controller: emailController,
          hintText: AppStrings.email,
          inputTextStyle: _inputColor(theme),
          backgroundColor: theme ? AppColors.kField2 : Colors.white,
          hintStyle: _hintStyle(theme),

        ),
        HelperMethod.verticalSpace(AppSizes.verticalSpacingS40),
        CustomElevatedButton(
          title: AppStrings.send,
          onPressed: ()async {
            await context.read<ForgetPasswordCubit>().forgetPassword(emailController.text);
          },
        ),
      ],
    );
  }

  TextStyle _hintStyle(bool theme) {
    return theme
        ? TextStyles.font14NormalGrey.copyWith(color: Colors.white)
        : TextStyles.font14NormalGrey;
  }

  TextStyle _inputColor(bool theme) {
    return theme
        ? TextStyles.font14NormalGrey.copyWith(color: Colors.white)
        : TextStyles.font14NormalGrey.copyWith(color: Colors.black);
  }
}
