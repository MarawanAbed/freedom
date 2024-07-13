import 'package:flutter/material.dart';
import 'package:freedom_chat_app/core/themes/styles.dart';
import 'package:freedom_chat_app/core/utils/sizes.dart';
import 'package:freedom_chat_app/core/utils/strings.dart';


import '../../../../core/helpers/helper_methods.dart';
import '../../../../core/themes/app_colors.dart';
import '../../../../core/widgets/app_text_form.dart';

class EdtProfileTextForm extends StatefulWidget {
  const EdtProfileTextForm({super.key, });


  @override
  State<EdtProfileTextForm> createState() => _EdtProfileTextFormState();
}

class _EdtProfileTextFormState extends State<EdtProfileTextForm> {
  late TextEditingController nameController;

  late TextEditingController emailController;

  late TextEditingController passwordController;

  late TextEditingController descriptionController;

  @override
  void initState() {
    // var cubit = UpdateUserCubit.get(context);
    // nameController = cubit.nameController;
    // emailController = cubit.emailController;
    // passwordController = cubit.passwordController;
    // descriptionController = cubit.descriptionController;
    nameController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    descriptionController = TextEditingController();

    super.initState();
  }

  bool obscureText = true;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context).brightness == Brightness.dark;
    return Column(
      children: [
        //nameController..text = widget.user.name!
        AppTextFormField(
          controller: nameController,
          hintText: AppStrings.name,
          inputTextStyle: _inputColor(theme),
          backgroundColor: theme ? AppColors.kField2 : Colors.white,
          hintStyle: _hintStyle(theme),
        ),
        HelperMethod.verticalSpace(AppSizes.verticalSpacingS20),
        AppTextFormField(
          controller: descriptionController,
          hintText: AppStrings.description,
          inputTextStyle: _inputColor(theme),
          backgroundColor: theme ? AppColors.kField2 : Colors.white,
          hintStyle: _hintStyle(theme),
        ),
        HelperMethod.verticalSpace(AppSizes.verticalSpacingS20),
        AppTextFormField(
          controller:emailController,
          hintText: AppStrings.email,
          inputTextStyle: _inputColor(theme),
          backgroundColor: theme ? AppColors.kField2 : Colors.white,
          hintStyle: _hintStyle(theme),
        ),
        HelperMethod.verticalSpace(AppSizes.verticalSpacingS20),
        AppTextFormField(
          controller: passwordController,
          hintText: AppStrings.password,
          inputTextStyle: _inputColor(theme),
          backgroundColor: theme ? AppColors.kField2 : Colors.white,
          hintStyle: _hintStyle(theme),
          isObscureText: obscureText,
          suffixIcon: IconButton(
            onPressed: () {
              setState(() {
                obscureText = !obscureText;
              });
            },
            icon: Icon(
              obscureText ? Icons.visibility_off : Icons.visibility,
              size: AppSizes.iconSizeS20,
              color: Theme.of(context).brightness == Brightness.dark
                  ? Colors.white
                  : Colors.grey,
            ),
          ),
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
