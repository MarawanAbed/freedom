import 'package:bloc/bloc.dart';
import 'package:freedom_chat_app/freedom/home/data/models/users.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'get_all_users_state.dart';
part 'get_all_users_cubit.freezed.dart';

class GetAllUsersCubit extends Cubit<GetAllUsersState> {
  GetAllUsersCubit() : super(const GetAllUsersState.initial());
}
