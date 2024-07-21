import 'package:flutter/material.dart';
import 'package:freedom_chat_app/core/helpers/helper_methods.dart';
import 'package:freedom_chat_app/core/utils/sizes.dart';
import 'package:freedom_chat_app/core/utils/strings.dart';
import 'package:freedom_chat_app/core/widgets/elevated_button.dart';
import 'package:freedom_chat_app/freedom/edit_profile/presentation/widgets/edit_profile_text_fields.dart';
import 'package:freedom_chat_app/freedom/edit_profile/presentation/widgets/change_profile_image.dart';

class EditProfileBody extends StatelessWidget {
  const EditProfileBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(AppSizes.kDefaultAllPaddingS20),
      child: SingleChildScrollView(
        child: Column(
          children: [
            HelperMethod.verticalSpace(AppSizes.verticalSpacingS20),
            const ChangeProfileImage(image: null),
            HelperMethod.verticalSpace(AppSizes.verticalSpacingS20),
            const EdtProfileTextForm(),
            HelperMethod.verticalSpace(AppSizes.verticalSpacingS30),
            CustomElevatedButton(
              title: AppStrings.saveChanges,
              onPressed: () async {
                // await _saveChanges(context);
              },
            ),
            HelperMethod.verticalSpace(AppSizes.verticalSpacingS10),
            Text(
              AppStrings.note,
              style: Theme.of(context).textTheme.bodySmall,
            ),
            // const EditProfileBlocListener(),
          ],
        ),
      ),
    );
  }
}
