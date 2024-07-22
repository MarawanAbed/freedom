import 'dart:io';

abstract class EditProfileRepo {
  Future<void> updateUser(Map<String, dynamic> data);
  Future<String> uploadImage(File path);
}