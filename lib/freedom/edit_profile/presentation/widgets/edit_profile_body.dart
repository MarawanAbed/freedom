import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freedom_chat_app/core/helpers/extension.dart';
import 'package:freedom_chat_app/core/helpers/helper_methods.dart';
import 'package:freedom_chat_app/core/routes/routes.dart';
import 'package:freedom_chat_app/core/utils/sizes.dart';
import 'package:freedom_chat_app/core/utils/strings.dart';
import 'package:freedom_chat_app/core/widgets/elevated_button.dart';
import 'package:freedom_chat_app/freedom/edit_profile/presentation/bloc/update_profile_cubit.dart';
import 'package:freedom_chat_app/freedom/edit_profile/presentation/widgets/change_profile_image.dart';
import 'package:freedom_chat_app/freedom/edit_profile/presentation/widgets/edit_profile_bloc_listener.dart';
import 'package:freedom_chat_app/freedom/edit_profile/presentation/widgets/edit_profile_text_fields.dart';
import 'package:freedom_chat_app/freedom/sign_up/data/models/user_model.dart';

class EditProfileBody extends StatelessWidget {
  const EditProfileBody({super.key, required this.user});

  final UserModel user;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(AppSizes.kDefaultAllPaddingS20),
      child: SingleChildScrollView(
        child: Column(
          children: [
            HelperMethod.verticalSpace(AppSizes.verticalSpacingS20),
            ChangeProfileImage(image: user.image),
            HelperMethod.verticalSpace(AppSizes.verticalSpacingS20),
            EdtProfileTextForm(user: user),
            HelperMethod.verticalSpace(AppSizes.verticalSpacingS30),
            CustomElevatedButton(
              title: AppStrings.saveChanges,
              onPressed: () async {
                await _saveChanges(context);
              },
            ),
            HelperMethod.verticalSpace(AppSizes.verticalSpacingS10),
            Text(
              AppStrings.note,
              style: Theme
                  .of(context)
                  .textTheme
                  .bodySmall,
            ),
            const EditProfileBlocListener(),
          ],
        ),
      ),
    );
  }

  Future<void> _saveChanges(BuildContext context) async {
    final cubit = context.read<UpdateProfileCubit>();
    final newUser = UserModel(
      uId: user.uId,
      name: cubit.nameController.text,
      email: cubit.emailController.text,
      password: cubit.passwordController.text,
      description: cubit.descriptionController.text,
      image: user.image,
      address: cubit.addressController.text,
      isOnline: user.isOnline,
      lastActive: user.lastActive,
      source: user.source,
    );

    if (cubit.profileImage != null && cubit.profileImage!.path != user.image) {
      cubit.imageUrl = await cubit.uploadImage(context);
      final users = UserModel(
        uId: user.uId,
        name: cubit.nameController.text,
        email: cubit.emailController.text,
        password: cubit.passwordController.text,
        description: cubit.descriptionController.text,
        image: cubit.imageUrl,
        address: cubit.addressController.text,
        isOnline: user.isOnline,
        lastActive: user.lastActive,
        source: user.source,
      );
      await cubit.updateProfile(users);
    }

    if (newUser.email != user.email) {
      await cubit
          .updateEmailOnly(
          newEmail: newUser.email!,
          password: user.password!,
          context: context)
          .then((value) async {
        await cubit.updateProfile(newUser);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            duration: Duration(seconds: 5),
            backgroundColor: Colors.green,
            content:
            Text('Check your new Email to verify your new Email address'),
          ),
        );
        Navigator.pushNamedAndRemoveUntil(
            context, Routes.signInPage, (route) => false);
      });
    }
    if (newUser.password != user.password && newUser.email != user.email) {
      cubit.updateEmailAndPassword(newEmail: newUser.email!,
          newPassword: newUser.password!,
          oldPassword: user.password!).then((_)
      {
        cubit.updateProfile(newUser).then((_) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              duration: Duration(seconds: 5),
              backgroundColor: Colors.green,
              content:
              Text('Check your new Email to verify your new Email address'),
            ),
          );
          Navigator.pushNamedAndRemoveUntil(
              context, Routes.signInPage, (route) => false);
        });
      });
    }
    if (newUser.password != user.password) {
      await cubit
          .updatePasswordOnly(
        newPassword: newUser.password!,
        oldPassword: user.password!,
        email: newUser.email!,
      ).then((value) {
        cubit.updateProfile(newUser).then((_) {
          context.pop();
        });
      });
    }

    if (newUser.name != user.name ||
        newUser.description != user.description ||
        newUser.address != user.address) {
      cubit.updateProfile(newUser).then((_) {
        context.pop();
      });
    }
  }
}
