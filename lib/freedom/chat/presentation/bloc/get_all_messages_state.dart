part of 'get_all_messages_cubit.dart';

@freezed
class GetAllMessagesState with _$GetAllMessagesState {
  const factory GetAllMessagesState.initial() = _Initial;

  const factory GetAllMessagesState.loading() = Loading;

  const factory GetAllMessagesState.success(List<Messages> messages) = Success;

  const factory GetAllMessagesState.error(String message) = Error;
}
