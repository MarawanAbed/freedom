part of 'sign_up_cubit.dart';

@freezed
class SignUpState with _$SignUpState {
  const factory SignUpState.initial() = _Initial;

  const factory SignUpState.loading() = Loading;

  const factory SignUpState.success() = Success;

  const factory SignUpState.error(String message) = Error;
}
