import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freedom_chat_app/core/di/dependancy_injection.dart';
import 'package:freedom_chat_app/core/services/notification_services.dart';
import 'package:freedom_chat_app/freedom/sign_in/domain/use_cases/sign_in_with_email_and_password.dart';
import 'package:freedom_chat_app/freedom/sign_in/domain/use_cases/sign_in_with_github.dart';
import 'package:freedom_chat_app/freedom/sign_in/domain/use_cases/sign_in_with_google.dart';
import 'package:freedom_chat_app/freedom/sign_in/domain/use_cases/sign_in_with_twitter.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'sign_in_cubit.freezed.dart';
part 'sign_in_state.dart';

class SignInCubit extends Cubit<SignInState> {
  SignInCubit(
      this._signInWithEmailAndPasswordUseCase,
      this._signInWithGithubUseCase,
      this._signInWithGoogleUseCase,
      this._signInWithTwitterUseCase)
      : super(const SignInState.initial());

  final SignInWithEmailAndPasswordUseCase _signInWithEmailAndPasswordUseCase;
  final SignInWithGithubUseCase _signInWithGithubUseCase;
  final SignInWithGoogleUseCase _signInWithGoogleUseCase;
  final SignInWithTwitterUseCase _signInWithTwitterUseCase;
  late TextEditingController emailController;
  late TextEditingController passwordController;
  final formKey = GlobalKey<FormState>();

  Future<void> signInWithEmailAndPassword() async {
    try {
      if(formKey.currentState!.validate()){
        emit(const SignInState.loading());
        await _signInWithEmailAndPasswordUseCase(emailController.text.trim(), passwordController.text.trim());
        await getIt<RemoteNotificationService>().requestPermission();
        await getIt<RemoteNotificationService>().getToken();
        emit(const SignInState.success());
      }
    } catch (e) {
      emit(SignInState.error(e.toString()));
    }
  }

  Future<void> signInWithGoogle() async {
    try {
      emit(const SignInState.loading());
      await _signInWithGoogleUseCase();
      await getIt<RemoteNotificationService>().requestPermission();
      await getIt<RemoteNotificationService>().getToken();
      emit(const SignInState.success());
    } catch (e) {
      emit(SignInState.error(e.toString()));
    }
  }

  Future<void> signInWithGithub(context) async {
    try {
      await _signInWithGithubUseCase.call(context);
      await getIt<RemoteNotificationService>().requestPermission();
      await getIt<RemoteNotificationService>().getToken();
      emit(const SignInState.successWithGitHub());
    } catch (e) {
      emit(SignInState.errorWithGitHub(e.toString()));
    }

  }
  Future<void> signInWithTwitter() async {
    try {
      emit(const SignInState.loading());
      await _signInWithTwitterUseCase();
      await getIt<RemoteNotificationService>().requestPermission();
      await getIt<RemoteNotificationService>().getToken();
      emit(const SignInState.success());
    } catch (e) {
      emit(SignInState.error(e.toString()));
    }
  }


  @override
  Future<void> close() {
    emailController.dispose();
    passwordController.dispose();
    return super.close();
  }
}
