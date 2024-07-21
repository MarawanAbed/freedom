import 'package:flutter/material.dart';
import 'package:freedom_chat_app/core/helpers/helper_methods.dart';
import 'package:freedom_chat_app/core/themes/styles.dart';
import 'package:freedom_chat_app/core/utils/sizes.dart';
import 'package:freedom_chat_app/core/widgets/profile_image.dart';

import '../../../sign_up/data/models/user_model.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({
    super.key, required this.user,
  });
  final UserModel user;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ProfileImage(
          image:  NetworkImage(user.image!,),
          radius: 50,
        ),
        HelperMethod.verticalSpace(AppSizes.verticalSpacingS30),
        Text(
          user.name!,
          style: TextStyles.font22Bold,
        ),
      ],
    );
  }
}
