import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'send_messages_state.dart';
part 'send_messages_cubit.freezed.dart';

class SendMessagesCubit extends Cubit<SendMessagesState> {
  SendMessagesCubit() : super(const SendMessagesState.initial());
}
