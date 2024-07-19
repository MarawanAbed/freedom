part of 'update_profile_cubit.dart';

@freezed
class UpdateProfileState with _$UpdateProfileState {
  const factory UpdateProfileState.initial() = _Initial;

  const factory UpdateProfileState.loading() = Loading;

  const factory UpdateProfileState.success() = Success;

  const factory UpdateProfileState.error(String message) = Error;
}
