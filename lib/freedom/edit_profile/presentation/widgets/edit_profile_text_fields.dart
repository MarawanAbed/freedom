import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freedom_chat_app/core/themes/styles.dart';
import 'package:freedom_chat_app/core/utils/sizes.dart';
import 'package:freedom_chat_app/core/utils/strings.dart';
import 'package:freedom_chat_app/freedom/edit_profile/presentation/bloc/update_profile_cubit.dart';


import '../../../../core/helpers/helper_methods.dart';
import '../../../../core/themes/app_colors.dart';
import '../../../../core/widgets/app_text_form.dart';
import '../../../sign_up/data/models/user_model.dart';

class EdtProfileTextForm extends StatefulWidget {
  const EdtProfileTextForm({super.key, required this.user, });

  final UserModel user;
  @override
  State<EdtProfileTextForm> createState() => _EdtProfileTextFormState();
}

class _EdtProfileTextFormState extends State<EdtProfileTextForm> {


  @override
  void initState() {
    var cubit=context.read<UpdateProfileCubit>();
    cubit.emailController=TextEditingController(text: widget.user.email);
    cubit.nameController=TextEditingController(text: widget.user.name);
    cubit.descriptionController=TextEditingController(text: widget.user.description);
    cubit.passwordController=TextEditingController(text: widget.user.password);
    cubit.addressController=TextEditingController(text: widget.user.address);
    super.initState();
  }

  bool obscureText = true;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context).brightness == Brightness.dark;
    var cubit=context.read<UpdateProfileCubit>();
    return Column(
      children: [
        //nameController..text = widget.user.name!
        AppTextFormField(
          controller: cubit.nameController,
          hintText: AppStrings.name,
          inputTextStyle: _inputColor(theme),
          backgroundColor: theme ? AppColors.kField2 : Colors.white,
          hintStyle: _hintStyle(theme),
        ),
        HelperMethod.verticalSpace(AppSizes.verticalSpacingS20),
        AppTextFormField(
          controller:cubit.descriptionController,
          hintText: AppStrings.description,
          inputTextStyle: _inputColor(theme),
          backgroundColor: theme ? AppColors.kField2 : Colors.white,
          hintStyle: _hintStyle(theme),
        ),
        HelperMethod.verticalSpace(AppSizes.verticalSpacingS20),
        AppTextFormField(
          controller:cubit.emailController,
          hintText: AppStrings.email,
          inputTextStyle: _inputColor(theme),
          backgroundColor: theme ? AppColors.kField2 : Colors.white,
          hintStyle: _hintStyle(theme),
        ),
        HelperMethod.verticalSpace(AppSizes.verticalSpacingS20),
        AppTextFormField(
          controller:cubit.addressController,
          hintText: AppStrings.address,
          inputTextStyle: _inputColor(theme),
          backgroundColor: theme ? AppColors.kField2 : Colors.white,
          hintStyle: _hintStyle(theme),
        ),
        HelperMethod.verticalSpace(AppSizes.verticalSpacingS20),
        AppTextFormField(
          controller: cubit.passwordController,
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
