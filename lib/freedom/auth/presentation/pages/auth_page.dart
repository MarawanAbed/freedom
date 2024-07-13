import 'package:flutter/material.dart';
import 'package:freedom_chat_app/freedom/auth/presentation/widgets/auth_body.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: AuthBody(),
    );
  }
}
