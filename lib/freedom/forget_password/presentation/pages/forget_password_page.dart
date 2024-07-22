import 'package:flutter/material.dart';
import 'package:freedom_chat_app/freedom/forget_password/presentation/widgets/forget_password_body.dart';

class ForgetPasswordPage extends StatelessWidget {
  const ForgetPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: ForgetPasswordBody(),
      ),
    );
  }
}
