import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freedom_chat_app/core/helpers/helper_methods.dart';
import 'package:freedom_chat_app/core/themes/app_colors.dart';
import 'package:freedom_chat_app/core/themes/styles.dart';
import 'package:freedom_chat_app/core/utils/sizes.dart';
import 'package:freedom_chat_app/core/utils/strings.dart';
import 'package:freedom_chat_app/core/widgets/app_text_form.dart';
import 'package:freedom_chat_app/freedom/search/presentation/bloc/search_users_cubit.dart';
import 'package:freedom_chat_app/freedom/search/presentation/widgets/search_bloc_builder.dart';

class SearchBody extends StatelessWidget {
  const SearchBody ({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context).brightness == Brightness.dark;

    return Padding(
      padding: EdgeInsets.all(AppSizes.kDefaultAllPaddingS20),
      child: Column(
        children: [
          AppTextFormField(
            hintText: AppStrings.searchUsers,
            inputTextStyle: _inputColor(theme),
            backgroundColor: theme ? AppColors.kField2 : Colors.white,
            hintStyle: _hintStyle(theme),
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

  TextStyle _hintStyle(bool theme) {
    return theme
        ? TextStyles.font14NormalGrey.copyWith(color: Colors.white)
        : TextStyles.font14NormalGrey;
  }

  TextStyle _inputColor(bool theme) {
    return theme
        ? TextStyles.font14NormalGrey.copyWith(color: Colors.white)
        : TextStyles.font14NormalGrey.copyWith(color: Colors.black);
  }
}
