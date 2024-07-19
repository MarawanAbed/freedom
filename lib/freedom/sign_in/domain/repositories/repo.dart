import 'package:flutter/material.dart';

abstract class SignInRepo
{
  Future<void> signInWithEmailAndPassword(String email, String password);

  Future<void> signInWithGoogle();

  Future<void> signInWithTwitter();

  Future<void> signInWithGitHub(BuildContext context);
}