import 'package:flutter/material.dart';
import 'package:freedom_chat_app/core/helpers/helper_methods.dart';
import 'package:freedom_chat_app/core/themes/styles.dart';
import 'package:freedom_chat_app/core/utils/sizes.dart';
import 'package:freedom_chat_app/core/widgets/profile_image.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ProfileImage(
          image: const NetworkImage('https://picsum.photos/200'),
          radius: AppSizes.profileRadius,
        ),
        HelperMethod.verticalSpace(AppSizes.verticalSpacingS30),
        Text(
          'marwan',
          style: TextStyles.font22Bold,
        ),
      ],
    );
  }
}
