import 'package:flutter/material.dart';
import 'package:freedom_chat_app/core/helpers/extension.dart';
import 'package:freedom_chat_app/core/routes/routes.dart';
import 'package:freedom_chat_app/core/themes/styles.dart';
import 'package:freedom_chat_app/core/utils/sizes.dart';
import 'package:freedom_chat_app/freedom/sign_up/data/models/user_model.dart';

import '../../../../core/widgets/custom_profile_image.dart';

class SearchItems extends StatelessWidget {
  const SearchItems({
    super.key,
    required this.user,
  });

  final UserModel user;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.pushNamed(Routes.chatPage, arguments: {
          'user': user,
          'senderId': user.uId,
        });
      },
      child: ListTile(
        leading: CustomProfileImage(
          user: user,
        ),
        title: Text(
          user.name!,
          style: TextStyles.font18Normal,
        ),
        contentPadding: EdgeInsets.all(AppSizes.kDefaultAllPaddingS10),
        subtitle: Padding(
          padding: EdgeInsets.only(top: AppSizes.kDefaultAllPaddingS10),
          child: Text(
            user.email!,
            style: TextStyles.font14NormalGrey,
            textAlign: TextAlign.start,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
        ),
      ),
    );
  }
}
