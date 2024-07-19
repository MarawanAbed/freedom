import 'package:flutter/material.dart';
import 'package:freedom_chat_app/core/usecases/use_cases.dart';
import 'package:freedom_chat_app/freedom/sign_in/domain/repositories/repo.dart';

class SignInWithGithubUseCase extends UseCase<Future<void>,BuildContext>
{
  final SignInRepo _repo;

  SignInWithGithubUseCase({required SignInRepo repo}) : _repo = repo;
  @override
  Future<void> call([BuildContext? parameter])async {
    await _repo.signInWithGitHub(parameter!);
  }

}