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
      await cubit.updateProfile(users).then((_) {
        context.pop();
      });
    }

    if (newUser.email != user.email && newUser.password != user.password) {
      await cubit
          .updateEmailAndPassword(
        newEmail: newUser.email!,
        newPassword: newUser.password!,
        oldPassword: user.password!,
      )
          .then((_) async {
        await cubit.updateProfile(newUser);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            duration: Duration(seconds: 5),
            backgroundColor: Colors.green,
            content: Text('Check your new Email to verify your new Email address'),
          ),
        );
        Navigator.pushNamedAndRemoveUntil(
            context, Routes.signInPage, (route) => false);
      });
    } else if (newUser.email != user.email) {
      await cubit
          .updateEmailOnly(
        newEmail: newUser.email!,
        password: user.password!,
        context: context,
      )
          .then((_) async {
        await cubit.updateProfile(newUser);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            duration: Duration(seconds: 5),
            backgroundColor: Colors.green,
            content: Text('Check your new Email to verify your new Email address'),
          ),
        );
        Navigator.pushNamedAndRemoveUntil(
            context, Routes.signInPage, (route) => false);
      });
    } else if (newUser.password != user.password) {
      await cubit
          .updatePasswordOnly(
        newPassword: newUser.password!,
        oldPassword: user.password!,
        email: newUser.email!,
      )
          .then((_) async {
        await cubit.updateProfile(newUser);
        context.pop();
      });
    }

    if (newUser.name != user.name ||
        newUser.description != user.description ||
        newUser.address != user.address) {
      await cubit.updateProfile(newUser).then((_) {
        context.pop();
      });
    }
  }
}
