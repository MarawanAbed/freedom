import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freedom_chat_app/freedom/chat/data/models/messages.dart';
import 'package:freedom_chat_app/freedom/chat/domain/repositories/repo.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'get_all_messages_state.dart';
part 'get_all_messages_cubit.freezed.dart';

class GetAllMessagesCubit extends Cubit<GetAllMessagesState> {
  GetAllMessagesCubit(this._repo) : super(const GetAllMessagesState.initial());


  final ChatRepo _repo;

  void getAllMessages(String receiverId) {
    emit(const GetAllMessagesState.loading());
    _repo.getAllMessage(receiverId).listen((messages) {
      if(!isClosed)
      {
        emit(GetAllMessagesState.success(messages));
      }
    }, onError: (e) {
      if(!isClosed)
      {
        emit(GetAllMessagesState.error(e.toString()));
      }
    });
  }
}
