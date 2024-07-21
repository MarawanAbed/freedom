import 'package:flutter/material.dart';
import 'package:freedom_chat_app/core/utils/sizes.dart';
import 'package:freedom_chat_app/freedom/sign_up/data/models/user_model.dart';

class CustomProfileImage extends StatelessWidget {
  const CustomProfileImage({super.key, required this.user, });

  final UserModel user;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              image: NetworkImage(user.image!),
              fit: BoxFit.cover,
            ),
          ),
        ),
        if (user.isOnline!) Positioned(
          right: 0,
          bottom: 0,
          child: Container(
            width: 15,
            height: 15,
            decoration: BoxDecoration(
              color: Colors.green,
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.white,
                width: AppSizes.stateBorderWidth,
              ),
            ),
          ),
        ) else Positioned(
          right: 0,
          bottom: 0,
          child: Container(
            width: 15,
            height: 15,
            decoration: BoxDecoration(
              color: Colors.red,
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.white,
                width: AppSizes.stateBorderWidth,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
