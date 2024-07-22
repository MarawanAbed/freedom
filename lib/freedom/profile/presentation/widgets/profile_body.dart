import 'package:flutter/material.dart';
import 'package:freedom_chat_app/core/helpers/extension.dart';
import 'package:freedom_chat_app/core/routes/routes.dart';
import 'package:freedom_chat_app/core/utils/sizes.dart';
import 'package:freedom_chat_app/core/utils/strings.dart';
import 'package:freedom_chat_app/freedom/profile/presentation/widgets/profile_header.dart';
import 'package:freedom_chat_app/freedom/sign_up/data/models/user_model.dart';

import '../../../../core/helpers/helper_methods.dart';
import '../../../../core/widgets/elevated_button.dart';
import 'build_row_info.dart';

class ProfileBody extends StatelessWidget {
  const ProfileBody({
    super.key, required this.user,
  });
  final UserModel user;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(AppSizes.kDefaultAllPaddingS20),
      child: Center(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ProfileHeader(user: user),
              HelperMethod.verticalSpace(AppSizes.verticalSpacingS30),
              BuildRowInfo(user: user),
              HelperMethod.verticalSpace(AppSizes.verticalSpacingS30),
              CustomElevatedButton(
                onPressed: () {
                  if(user.source=='local')
                  {
                    context.pushNamed(Routes.editProfilePage, arguments: user);
                  }else
                  {
                    HelperMethod.showErrorToast('You cant Edit Profile from ${user.source} account');
                  }
                },
                title: AppStrings.editProfile,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
