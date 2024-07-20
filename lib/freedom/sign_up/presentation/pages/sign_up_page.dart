import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freedom_chat_app/core/di/dependancy_injection.dart';
import 'package:freedom_chat_app/freedom/sign_up/presentation/bloc/sign_up_cubit.dart';
import 'package:freedom_chat_app/freedom/sign_up/presentation/widgets/sign_up_body.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  late SignUpCubit _cubit;

  @override
  void initState() {
    _cubit = getIt<SignUpCubit>();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _cubit,
      child:  Scaffold(
        body: SignUpBody(cubit: _cubit),
      ),
    );
  }
}
