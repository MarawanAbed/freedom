import 'package:flutter/material.dart';
import 'package:freedom_chat_app/core/utils/strings.dart';
import 'package:freedom_chat_app/freedom/edit_profile/presentation/widgets/edit_profile_body.dart';

class EditProfilePage extends StatelessWidget {
  const EditProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        shadowColor: Colors.white,
        surfaceTintColor: Colors.white,
        title: const Text(AppStrings.editProfile),
      ),
      body: const EditProfileBody(),
    );
  }
}
