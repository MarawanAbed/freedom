import 'package:flutter/material.dart';
import 'package:freedom_chat_app/core/utils/strings.dart';
import 'package:freedom_chat_app/freedom/edit_profile/presentation/widgets/edit_profile_body.dart';
import 'package:freedom_chat_app/freedom/sign_up/data/models/user_model.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  late UserModel user;

  @override
  void didChangeDependencies() {
    user = ModalRoute.of(context)!.settings.arguments as UserModel;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.editProfile),
      ),
      body: EditProfileBody(
        user: user,
      ),
    );
  }
}
