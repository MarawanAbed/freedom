import 'package:bloc/bloc.dart';
import 'package:freedom_chat_app/freedom/chat/data/models/messages.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'get_all_messages_state.dart';
part 'get_all_messages_cubit.freezed.dart';

class GetAllMessagesCubit extends Cubit<GetAllMessagesState> {
  GetAllMessagesCubit() : super(const GetAllMessagesState.initial());
}
