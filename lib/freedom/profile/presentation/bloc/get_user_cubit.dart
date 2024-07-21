import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freedom_chat_app/freedom/sign_up/data/models/user_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/repositories/repo.dart';

part 'get_user_state.dart';
part 'get_user_cubit.freezed.dart';

class GetUserCubit extends Cubit<GetUserState> {
  GetUserCubit(this._profileRepo) : super(const GetUserState.initial());
  final ProfileRepo _profileRepo;

  void getUser() {
    emit(const GetUserState.loading());
    _profileRepo.getUser().listen((user) {
      emit(GetUserState.success(user));
    }, onError: (e) {
      emit(GetUserState.error(e.toString()));
    });
  }
}
