import 'package:flutter/material.dart';
import 'package:freedom_chat_app/core/utils/sizes.dart';
import 'package:freedom_chat_app/core/utils/strings.dart';
import 'package:freedom_chat_app/freedom/profile/presentation/widgets/profile_header.dart';

import '../../../../core/helpers/helper_methods.dart';
import '../../../../core/widgets/elevated_button.dart';
import 'build_row_info.dart';

class ProfileBody extends StatelessWidget {
  const ProfileBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(AppSizes.kDefaultAllPaddingS20),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const ProfileHeader(),
            HelperMethod.verticalSpace(AppSizes.verticalSpacingS30),
            const BuildRowInfo(),
            HelperMethod.verticalSpace(AppSizes.verticalSpacingS30),
            CustomElevatedButton(
              onPressed: () {
                // context.pushNamed(Routes.editProfileScreen, arguments: user);
              },
              title: AppStrings.editProfile,
            ),
          ],
        ),
      ),
    );
  }
}
