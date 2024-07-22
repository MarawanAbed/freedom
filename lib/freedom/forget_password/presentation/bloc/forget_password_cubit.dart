import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freedom_chat_app/freedom/forget_password/domain/use_cases/forget_password.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'forget_password_state.dart';
part 'forget_password_cubit.freezed.dart';

class ForgetPasswordCubit extends Cubit<ForgetPasswordState> {
  ForgetPasswordCubit(this._useCase) : super(const ForgetPasswordState.initial());
  final ForgetPasswordUseCase _useCase;

  Future<void> forgetPassword(String email) async {
    emit(const ForgetPasswordState.loading());
    try {
      await _useCase(email);
      emit(const ForgetPasswordState.success());
    } catch (e) {
      emit(ForgetPasswordState.error(e.toString()));
    }
  }
}
