import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freedom_chat_app/freedom/sign_up/presentation/bloc/sign_up_cubit.dart';
import 'package:freedom_chat_app/freedom/sign_up/presentation/widgets/complete_your_sign_up_body.dart';

class CompleteYourSignUpPage extends StatefulWidget {
  const CompleteYourSignUpPage({super.key});

  @override
  State<CompleteYourSignUpPage> createState() => _CompleteYourSignUpPageState();
}

class _CompleteYourSignUpPageState extends State<CompleteYourSignUpPage> {
  late SignUpCubit _cubit;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _cubit = ModalRoute.of(context)!.settings.arguments as SignUpCubit;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _cubit,
      child: SafeArea(
        child: Scaffold(
          body: CompleteYourSignUpBody(cubit: _cubit),
        ),
      ),
    );
  }

}