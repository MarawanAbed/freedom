import 'package:bloc/bloc.dart';
import 'package:freedom_chat_app/freedom/sign_up/data/models/user_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'get_user_state.dart';
part 'get_user_cubit.freezed.dart';

class GetUserCubit extends Cubit<GetUserState> {
  GetUserCubit() : super(const GetUserState.initial());
}
