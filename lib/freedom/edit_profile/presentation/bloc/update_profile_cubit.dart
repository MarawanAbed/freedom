import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freedom_chat_app/core/di/dependancy_injection.dart';
import 'package:freedom_chat_app/core/services/firebase_services.dart';
import 'package:freedom_chat_app/freedom/edit_profile/domain/repositories/repo.dart';
import 'package:freedom_chat_app/freedom/edit_profile/domain/use_cases/update_profile.dart';
import 'package:freedom_chat_app/freedom/sign_up/data/models/user_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'update_profile_cubit.freezed.dart';
part 'update_profile_state.dart';

class UpdateProfileCubit extends Cubit<UpdateProfileState> {
  UpdateProfileCubit(this._profileUseCase, this._repo)
      : super(const UpdateProfileState.initial());

  final UpdateProfileUseCase _profileUseCase;
  final EditProfileRepo _repo;
  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController passwordController;
  late TextEditingController descriptionController;
  late TextEditingController addressController;

  File? profileImage;
  String? imageUrl;

  Future<void> updateProfile(UserModel user) async {
    emit(const UpdateProfileState.loading());
    try {
      await _profileUseCase.call(user.toJson());

      if (!isClosed) {
        emit(const UpdateProfileState.success());
      }
    } catch (e) {
      emit(UpdateProfileState.error(e.toString()));
    }
  }

  Future<String> uploadImage(context) async {
    emit(const UpdateProfileState.loading());
    if (profileImage == null) {
      return 'no image selected';
    }
    try {
      imageUrl = await _repo.uploadImage(profileImage!);
      return imageUrl ?? 'failed to upload image';
    } catch (e) {
      emit(UpdateProfileState.error(e.toString()));
      return 'failed to upload image';
    }
  }

  Future<void> updateEmailOnly({
    required String newEmail,
    required String password,
    required BuildContext context,
  }) async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      // Reauthenticate the user with the old password
      final userCredential = await user?.reauthenticateWithCredential(
        EmailAuthProvider.credential(
          email: user.email!,
          password: password,
        ),
      );
      await userCredential?.user?.verifyBeforeUpdateEmail(newEmail);
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> updatePasswordOnly({
    required String newPassword,
    required String oldPassword,
    required String email,
  }) async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      // Reauthenticate the user with the old password
      final userCredential = await user?.reauthenticateWithCredential(
        EmailAuthProvider.credential(
          email: user.email!,
          password: oldPassword,
        ),
      );
      await userCredential?.user?.updatePassword(newPassword);
      await signIn(email: email, password: newPassword);
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<UserCredential> signIn(
      {required String email, required String password}) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      await getIt<DatabaseService>().updateUser({
        'uId': FirebaseAuth.instance.currentUser!.uid,
        'lastActive': DateTime.now(),
        'isOnline': true,
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw Exception('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        throw Exception('Wrong password provided for that user.');
      }
    }
    //this after you update email and password there is problem might found so i add this
    //to update user data after update email and password
    return FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<void> updateEmailAndPassword({
    required String newEmail,
    required String newPassword,
    required String oldPassword,
  }) async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        print('No user is currently signed in.');
        return;
      }
      // Reauthenticate the user with the old password
      final userCredential = await user.reauthenticateWithCredential(
        EmailAuthProvider.credential(
          email: user.email!,
          password: oldPassword,
        ),
      );
      // Update email
      await userCredential.user?.verifyBeforeUpdateEmail(newEmail);
      // Update password
      await userCredential.user?.updatePassword(newPassword);
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Future<void> close() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    descriptionController.dispose();
    addressController.dispose();
    return super.close();
  }
}
