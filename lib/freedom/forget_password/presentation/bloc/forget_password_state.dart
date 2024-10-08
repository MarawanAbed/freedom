part of 'forget_password_cubit.dart';

@freezed
class ForgetPasswordState with _$ForgetPasswordState {
  const factory ForgetPasswordState.initial() = _Initial;

  const factory ForgetPasswordState.loading() = Loading;

  const factory ForgetPasswordState.success() = Success;

  const factory ForgetPasswordState.error(String message) = Error;
}
