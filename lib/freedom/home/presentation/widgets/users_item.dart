import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freedom_chat_app/core/helpers/extension.dart';
import 'package:freedom_chat_app/core/routes/routes.dart';
import 'package:freedom_chat_app/core/themes/styles.dart';
import 'package:freedom_chat_app/core/utils/sizes.dart';
import 'package:freedom_chat_app/core/widgets/custom_profile_image.dart';
import 'package:freedom_chat_app/freedom/home/presentation/bloc/home_cubit.dart';
import 'package:freedom_chat_app/freedom/sign_up/data/models/user_model.dart';
import 'package:timeago/timeago.dart' as timeago;

class UserItems extends StatefulWidget {
  const UserItems({
    super.key,
    required this.user,
  });

  final UserModel user;

  @override
  State<UserItems> createState() => _UserItemsState();
}

class _UserItemsState extends State<UserItems> {
  String userId = '';
  @override
  void initState() {
    userId=context.read<HomeCubit>().getUserId()??'';
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.pushNamed(Routes.chatPage, arguments: widget.user);
      },
      child: ListTile(
        leading: CustomProfileImage(
          user: widget.user,
        ),
        title: Text(
          userId == widget.user.uId ? 'You' : widget.user.name!,
          style: TextStyles.font18Normal,
        ),
        contentPadding: EdgeInsets.all(AppSizes.kDefaultAllPaddingS10),
        subtitle: Padding(
          padding: EdgeInsets.only(top: AppSizes.kDefaultAllPaddingS10),
          child: Text(
            widget.user.email!,
            style: TextStyles.font14NormalGrey,
            textAlign: TextAlign.start,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
        ),
        trailing: Text(
          timeago.format(widget.user.lastActive!),
          style: TextStyles.font14Normal,
        ),
      ),
    );
  }
}
