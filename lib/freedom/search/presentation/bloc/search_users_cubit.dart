import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freedom_chat_app/freedom/search/domain/use_cases/search_users.dart';
import 'package:freedom_chat_app/freedom/sign_up/data/models/user_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'search_users_state.dart';
part 'search_users_cubit.freezed.dart';

class SearchUsersCubit extends Cubit<SearchUsersState> {
  SearchUsersCubit(this._usersUseCase) : super(const SearchUsersState.initial());

  final SearchUsersUseCase _usersUseCase;


  void search(String query)  {
    try {
      final users =  _usersUseCase(query);
      users.listen((events){
        if(!isClosed)
        {
          emit(SearchUsersState.success(events));
        }
      });
    } catch (e) {
      emit(SearchUsersState.error(e.toString()));
    }
  }

  void clear() {
    emit(const SearchUsersState.initial());
  }
}
