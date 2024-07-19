part of 'send_messages_cubit.dart';

@freezed
class SendMessagesState with _$SendMessagesState {
  const factory SendMessagesState.initial() = _Initial;

  const factory SendMessagesState.loading() = Loading;

  const factory SendMessagesState.success() = Success;

  const factory SendMessagesState.error(String message) = Error;
}
