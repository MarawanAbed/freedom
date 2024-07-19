part of 'get_all_users_cubit.dart';

@freezed
class GetAllUsersState with _$GetAllUsersState {
  const factory GetAllUsersState.initial() = _Initial;

  const factory GetAllUsersState.loading() = Loading;

  const factory GetAllUsersState.success(List<Users> users) = Success;

  const factory GetAllUsersState.error(String message) = Error;
}
