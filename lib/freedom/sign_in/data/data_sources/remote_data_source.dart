import 'package:flutter/material.dart';
import 'package:freedom_chat_app/core/services/firebase_services.dart';

abstract class SignInRemoteDataSource
{

  Future<void> signInWithEmailAndPassword(String email, String password);

  Future<void> signInWithGoogle();

  Future<void> signInWithTwitter();

  Future<void> signInWithGitHub(BuildContext context);
}

class SignInRemoteDataSourceImpl extends SignInRemoteDataSource
{
  final AuthService _authService;

  SignInRemoteDataSourceImpl({required AuthService authService}) : _authService = authService;


  @override
  Future<void> signInWithEmailAndPassword(String email, String password)async {
    await _authService.signIn(email: email, password: password);
  }

  @override
  Future<void> signInWithGitHub(BuildContext context)async {
    await _authService.signInWithGithub(context);
  }

  @override
  Future<void> signInWithGoogle()async {
    await _authService.signInWithGoogle();
  }

  @override
  Future<void> signInWithTwitter() async{
    await _authService.signInWithTwitter();
  }

}