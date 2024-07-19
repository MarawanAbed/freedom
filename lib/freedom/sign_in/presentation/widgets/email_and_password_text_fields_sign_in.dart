import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freedom_chat_app/core/helpers/helper_methods.dart';
import 'package:freedom_chat_app/core/helpers/validation.dart';
import 'package:freedom_chat_app/core/themes/app_colors.dart';
import 'package:freedom_chat_app/core/themes/styles.dart';
import 'package:freedom_chat_app/core/utils/sizes.dart';
import 'package:freedom_chat_app/core/utils/strings.dart';
import 'package:freedom_chat_app/core/widgets/app_text_form.dart';
import 'package:freedom_chat_app/freedom/sign_in/presentation/bloc/sign_in_cubit.dart';

class EmailAndPasswordTextFieldsSignIn extends StatefulWidget {
  const EmailAndPasswordTextFieldsSignIn({super.key});

  @override
  State<EmailAndPasswordTextFieldsSignIn> createState() => _EmailAndPasswordTextFieldsSignInState();
}

class _EmailAndPasswordTextFieldsSignInState extends State<EmailAndPasswordTextFieldsSignIn> {
  bool obscureText = true;
  @override
  void initState() {
    var cubit=context.read<SignInCubit>();
    cubit.emailController = TextEditingController();
    cubit.passwordController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context).brightness == Brightness.dark;
    var cubit=context.read<SignInCubit>();
    return Form(
      key: cubit.formKey,
      child: Column(
        children: [
          AppTextFormField(
            controller: cubit.emailController,
            hintText: AppStrings.email,
            inputTextStyle: _inputColor(theme),
            backgroundColor: theme ? AppColors.kField2 : Colors.white,
            hintStyle: _hintStyle(theme),
            validator: (email) => Validation.validateEmail(email ?? ''),
          ),
          HelperMethod.verticalSpace(AppSizes.verticalSpacingS20),
          AppTextFormField(
            controller: cubit.passwordController,
            hintText: AppStrings.password,
            inputTextStyle: _inputColor(theme),
            backgroundColor: theme ? AppColors.kField2 : Colors.white,
            hintStyle: _hintStyle(theme),
            isObscureText: obscureText,
            validator: (password) =>
                Validation.validatePassword(password ?? ''),
            suffixIcon: IconButton(
              onPressed: () {
                setState(() {
                  obscureText = !obscureText;
                });
              },
              icon: Icon(
                obscureText ? Icons.visibility_off : Icons.visibility,
                size: AppSizes.iconSizeS20,
                color: theme ? Colors.white : Colors.grey,
              ),
            ),
          ),
        ],
      ),
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
