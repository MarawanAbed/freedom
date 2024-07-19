import 'package:flutter/material.dart';
import 'package:freedom_chat_app/freedom/sign_in/presentation/widgets/sign_in_body.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: SignInBody(),
      ),
    );
  }
}
