part of 'sign_in_cubit.dart';

@freezed
class SignInState with _$SignInState {
  const factory SignInState.initial() = _Initial;

  const factory SignInState.loading() = Loading;

  const factory SignInState.success() = Success;

  const factory SignInState.error(String message) = Error;

  const factory SignInState.successWithGitHub() = SuccessWithGitHub;

  const factory SignInState.errorWithGitHub(String message) = ErrorWithGitHub;
}
