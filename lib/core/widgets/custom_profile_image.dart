import 'package:flutter/material.dart';
import 'package:freedom_chat_app/core/utils/sizes.dart';

class CustomProfileImage extends StatelessWidget {
  const CustomProfileImage({super.key, });


  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CircleAvatar(
          radius: AppSizes.circleAvatarRadius,
          child: ClipRRect(
              borderRadius: BorderRadius.circular(25),
              child: Image.network(
                'https://www.google.com/images/branding/googlelogo/1x/googlelogo_color_272x92dp.png',
                fit: BoxFit.cover,
              )),
        ),
        if (true) Positioned(
          right: 0,
          bottom: 0,
          child: Container(
            width: AppSizes.userStateSizeWidth,
            height: AppSizes.userStateSizeHeight,
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
            width: AppSizes.userStateSizeWidth,
            height: AppSizes.userStateSizeHeight,
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
