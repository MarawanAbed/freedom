import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freedom_chat_app/core/helpers/helper_methods.dart';
import 'package:freedom_chat_app/core/utils/sizes.dart';
import 'package:freedom_chat_app/core/utils/strings.dart';
import 'package:freedom_chat_app/core/widgets/app_text_form.dart';
import 'package:freedom_chat_app/freedom/search/presentation/bloc/search_users_cubit.dart';
import 'package:freedom_chat_app/freedom/search/presentation/widgets/search_bloc_builder.dart';

class SearchBody extends StatelessWidget {
  const SearchBody ({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(AppSizes.kDefaultAllPaddingS20),
      child: Column(
        children: [
          AppTextFormField(
            hintText: AppStrings.searchUsers,
            onChanged: (value) {
              if(value.isNotEmpty)
              {
                context.read<SearchUsersCubit>().search(value);
              }else
              {
                context.read<SearchUsersCubit>().clear();
              }
            },
          ),
          HelperMethod.verticalSpace(AppSizes.verticalSpacingS20),
          const SearchBlocBuilder(),
        ],
      ),
    );
  }
}
