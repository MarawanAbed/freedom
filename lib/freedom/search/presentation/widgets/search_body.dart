import 'package:flutter/material.dart';
import 'package:freedom_chat_app/core/helpers/helper_methods.dart';
import 'package:freedom_chat_app/core/utils/sizes.dart';
import 'package:freedom_chat_app/core/utils/strings.dart';
import 'package:freedom_chat_app/core/widgets/app_text_form.dart';

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
              // context.read<SearchUsersCubit>().searchUsers(value);
            },
          ),
          HelperMethod.verticalSpace(AppSizes.verticalSpacingS20),
          // const SearchBlocBuilder(),
        ],
      ),
    );
  }
}
