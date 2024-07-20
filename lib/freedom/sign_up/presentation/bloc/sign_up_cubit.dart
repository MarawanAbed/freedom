import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freedom_chat_app/freedom/sign_up/data/models/user_model.dart';
import 'package:freedom_chat_app/freedom/sign_up/domain/repositories/repo.dart';
import 'package:freedom_chat_app/freedom/sign_up/domain/use_cases/sign_up.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'sign_up_cubit.freezed.dart';
part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit(this._signUpUseCase, this._signUpRepository)
      : super(const SignUpState.initial());

  final SignUpUseCase _signUpUseCase;
  final SignUpRepository _signUpRepository;
  late TextEditingController emailController;
  late TextEditingController passwordController;
  late TextEditingController nameController;
  late TextEditingController descriptionController;
  late TextEditingController addressController;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  void initializeControllers() {
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  void disposeControllers() {
    emailController.dispose;
    passwordController.dispose;
  }

  File? profileImage;
  String? imageUrl;
  Future<void> signUp() async {
    emit(const SignUpState.loading());
    try {
      var uId=_signUpRepository.getUserId();
      final user = UserModel(
        uId: uId??'',
        name: nameController.text.trim(),
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
        image: imageUrl,
        lastActive: DateTime.now(),
        description: descriptionController.text.trim(),
        isOnline: true,
        source: 'local',
        address: addressController.text.trim(),
      );
      await _signUpUseCase(user);
      await _createUser( user);
    } catch (e) {
      emit(SignUpState.error(e.toString()));
    }
  }

  Future<void>_createUser(UserModel user)async
  {
    emit(const SignUpState.loading());
    try
    {
      await _signUpRepository.createUser(user);
      emit(const SignUpState.success());
    }catch (error)
    {
      emit(SignUpState.error(error.toString()));
    }
  }
  Future<String> uploadImage(context) async {
    emit(const SignUpState.loading());
    if (profileImage == null) {
      return 'no image selected';
    }
    try {
      imageUrl= await _signUpRepository.uploadImage(profileImage!);
      return imageUrl??'failed to upload image';
    } catch (e) {
      emit(SignUpState.error(e.toString()));
      return 'failed to upload image';
    }
  }
}
