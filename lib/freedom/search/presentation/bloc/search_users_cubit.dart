import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'search_users_state.dart';
part 'search_users_cubit.freezed.dart';

class SearchUsersCubit extends Cubit<SearchUsersState> {
  SearchUsersCubit() : super(const SearchUsersState.initial());
}
