import 'package:flutter/material.dart';
import 'package:freedom_chat_app/freedom/sign_up/presentation/widgets/complete_your_sign_up_body.dart';

class CompleteYourSignUpPage extends StatelessWidget {
  const CompleteYourSignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Scaffold(
        body: CompleteYourSignUpBody(),
      ),
    );
  }
}
