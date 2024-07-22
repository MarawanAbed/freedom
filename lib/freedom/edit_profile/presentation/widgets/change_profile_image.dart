import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:freedom_chat_app/core/helpers/helper_methods.dart';
import 'package:freedom_chat_app/core/utils/sizes.dart';
import 'package:freedom_chat_app/core/utils/strings.dart';
import 'package:freedom_chat_app/core/widgets/please_pick_image.dart';
import 'package:freedom_chat_app/core/widgets/profile_image.dart';
import 'package:freedom_chat_app/freedom/edit_profile/presentation/bloc/update_profile_cubit.dart';

class ChangeProfileImage extends StatefulWidget {
  const ChangeProfileImage({super.key, required this.image});

  final String? image;

  @override
  State<ChangeProfileImage> createState() => _ChangeProfileImageState();
}

class _ChangeProfileImageState extends State<ChangeProfileImage> {
  late File? _pickedImage;
  late String? _initialImage;

  @override
  void initState() {
    var cubit = context.read<UpdateProfileCubit>();
    cubit.profileImage = null;
    _pickedImage = cubit.profileImage;
    _initialImage = widget.image;
    super.initState();
  }

  Future<void> pickedImage() async {
    try {
      var cubit = context.read<UpdateProfileCubit>();
      File? newProfileImage = await HelperMethod.getImageFromGallery();
      setState(() {
        _pickedImage = newProfileImage;
      });
      cubit.profileImage = _pickedImage;
    } catch (e) {
      HelperMethod.showErrorToast(AppStrings.pleaseSelectImage,
          gravity: ToastGravity.BOTTOM);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ProfileImage(
          image: _pickedImage != null
              ? FileImage(_pickedImage!)
              : (_initialImage != null
                  ? NetworkImage(_initialImage!) as ImageProvider<Object>?
                  : null),
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
