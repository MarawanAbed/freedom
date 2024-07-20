import 'package:flutter/material.dart';
import 'package:freedom_chat_app/core/helpers/helper_methods.dart';
import 'package:freedom_chat_app/core/helpers/validation.dart';
import 'package:freedom_chat_app/core/themes/app_colors.dart';
import 'package:freedom_chat_app/core/themes/styles.dart';
import 'package:freedom_chat_app/core/utils/sizes.dart';
import 'package:freedom_chat_app/core/utils/strings.dart';
import 'package:freedom_chat_app/core/widgets/app_text_form.dart';
import 'package:freedom_chat_app/freedom/sign_up/presentation/bloc/sign_up_cubit.dart';

class CompleteYourSignUpTextFieldSignUp extends StatefulWidget {
  const CompleteYourSignUpTextFieldSignUp({super.key, required this.cubit});

  final SignUpCubit cubit;

  @override
  State<CompleteYourSignUpTextFieldSignUp> createState() =>
      _CompleteYourSignUpTextFieldSignUpState();
}

class _CompleteYourSignUpTextFieldSignUpState
    extends State<CompleteYourSignUpTextFieldSignUp> {
  bool obscureText = true;

  @override
  void initState() {
    var cubit = widget.cubit;
    cubit.nameController = TextEditingController();
    cubit.descriptionController = TextEditingController();
    cubit.addressController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    var cubit = widget.cubit;
    cubit.nameController.dispose();
    cubit.descriptionController.dispose();
    cubit.addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context).brightness == Brightness.dark;
    var cubit = widget.cubit;
    return Form(
      key: cubit.formKey,
      child: Column(
        children: [
          AppTextFormField(
            controller: cubit.nameController,
            hintText: AppStrings.name,
            inputTextStyle: _inputColor(theme),
            backgroundColor: theme ? AppColors.kField2 : Colors.white,
            hintStyle: _hintStyle(theme),
            validator: (name) => Validation.validateRequired(name ?? ''),
          ),
          HelperMethod.verticalSpace(AppSizes.verticalSpacingS20),
          AppTextFormField(
            controller: cubit.descriptionController,
            hintText: AppStrings.description,
            inputTextStyle: _inputColor(theme),
            backgroundColor: theme ? AppColors.kField2 : Colors.white,
            hintStyle: _hintStyle(theme),
            validator: (description) =>
                Validation.validateRequired(description ?? ''),
          ),
          HelperMethod.verticalSpace(AppSizes.verticalSpacingS20),
          AppTextFormField(
            controller: cubit.addressController,
            hintText: AppStrings.address,
            inputTextStyle: _inputColor(theme),
            backgroundColor: theme ? AppColors.kField2 : Colors.white,
            hintStyle: _hintStyle(theme),
            validator: (name) => Validation.validateRequired(name ?? ''),
          ),
          HelperMethod.verticalSpace(AppSizes.verticalSpacingS20),
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
