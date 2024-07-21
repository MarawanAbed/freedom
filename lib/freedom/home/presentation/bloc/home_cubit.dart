import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freedom_chat_app/freedom/home/domain/repositories/repo.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../sign_up/data/models/user_model.dart';

part 'home_cubit.freezed.dart';
part 'home_cubit_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this._homeRepo) : super(const HomeState.initial());

  final HomeRepo _homeRepo;

  void getAllUsers() {
    emit(const HomeState.loading());
    try {
      final Stream<List<UserModel>> users = _homeRepo.getAllUsers();
      users.listen((event) {
        emit(HomeState.success(event));
      });
    } catch (e) {
      emit(HomeState.error(e.toString()));
    }
  }

}
