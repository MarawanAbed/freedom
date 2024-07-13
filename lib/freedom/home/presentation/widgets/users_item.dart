import 'package:flutter/material.dart';
import 'package:freedom_chat_app/core/themes/styles.dart';
import 'package:freedom_chat_app/core/utils/sizes.dart';
import 'package:freedom_chat_app/core/widgets/custom_profile_image.dart';
import 'package:timeago/timeago.dart' as timeago;


class UserItems extends StatelessWidget {
  const UserItems({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {},
      child: GestureDetector(
        onTap: () {
          // context.pushNamed(Routes.chatScreen, arguments: user);
        },
        child: ListTile(
          leading: const CustomProfileImage(),
          title: Text(
            'marwan',
            style: TextStyles.font18Normal,
          ),
          contentPadding: EdgeInsets.all(AppSizes.kDefaultAllPaddingS10),
          subtitle: Padding(
            padding: EdgeInsets.only(top: AppSizes.kDefaultAllPaddingS10),
            child: Text(
              'last message',
              style: TextStyles.font14NormalGrey,
              textAlign: TextAlign.start,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
          trailing: Text(
            timeago.format(DateTime.now()),
            style: TextStyles.font14Normal,
          ),
        ),
      ),
    );
  }
}
