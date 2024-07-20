import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:freedom_chat_app/core/helpers/helper_methods.dart';
import 'package:freedom_chat_app/core/utils/sizes.dart';
import 'package:freedom_chat_app/core/utils/strings.dart';
import 'package:freedom_chat_app/core/widgets/please_pick_image.dart';
import 'package:freedom_chat_app/core/widgets/profile_image.dart';
import 'package:freedom_chat_app/freedom/sign_up/presentation/bloc/sign_up_cubit.dart';

class ChangeProfileImage extends StatefulWidget {
  const ChangeProfileImage({super.key, required this.cubit});

  final SignUpCubit cubit;

  @override
  State<ChangeProfileImage> createState() => _ChangeProfileImageState();
}

class _ChangeProfileImageState extends State<ChangeProfileImage> {
  @override
  initState() {
    widget.cubit.profileImage = null;
    super.initState();
  }

  pickedImage() async {
    try {
      File? newProfileImage = await HelperMethod.getImageFromGallery();
      setState(() {
        widget.cubit.profileImage = newProfileImage;
      });
    } catch (e) {
      HelperMethod.showErrorToast(AppStrings.errorPickedImage,
          gravity: ToastGravity.BOTTOM);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ProfileImage(
          image: widget.cubit.profileImage == null
              ? null
              : FileImage(widget.cubit.profileImage!),
          radius: AppSizes.profileRadius,
        ),
        HelperMethod.verticalSpace(AppSizes.verticalSpacingS10),
        ChooseProfileImage(
          onTap: () async {
            await pickedImage();
          },
        ),
      ],
    );
  }
}
