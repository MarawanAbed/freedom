import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freedom_chat_app/core/helpers/helper_methods.dart';
import 'package:freedom_chat_app/core/helpers/validation.dart';
import 'package:freedom_chat_app/core/themes/app_colors.dart';
import 'package:freedom_chat_app/core/themes/styles.dart';
import 'package:freedom_chat_app/core/utils/sizes.dart';
import 'package:freedom_chat_app/core/utils/strings.dart';
import 'package:freedom_chat_app/core/widgets/app_text_form.dart';
import 'package:freedom_chat_app/freedom/sign_up/presentation/bloc/sign_up_cubit.dart';

class EmailAndPasswordTextFieldsSignUp extends StatefulWidget {
  const EmailAndPasswordTextFieldsSignUp({super.key, required this.cubit, required this.formKey});
  final SignUpCubit cubit;
  final GlobalKey<FormState> formKey ;
  @override
  State<EmailAndPasswordTextFieldsSignUp> createState() =>
      _EmailAndPasswordTextFieldsSignUpState();
}

class _EmailAndPasswordTextFieldsSignUpState
    extends State<EmailAndPasswordTextFieldsSignUp> {
  bool obscureText = true;
  late GlobalKey<FormState>_formKey ;
  late SignUpCubit _cubit;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _cubit = widget.cubit;
    _formKey = widget.formKey;
    _cubit.initializeControllers();
  }

  @override
  void dispose() {
    _cubit.disposeControllers();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context).brightness == Brightness.dark;
    var cubit = context.read<SignUpCubit>();
    return Form(
      key: _formKey,
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
