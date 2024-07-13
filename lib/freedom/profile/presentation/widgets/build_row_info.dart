import 'package:flutter/material.dart';
import 'package:freedom_chat_app/core/helpers/helper_methods.dart';
import 'package:freedom_chat_app/core/utils/sizes.dart';
import 'package:freedom_chat_app/core/utils/strings.dart';

class BuildRowInfo extends StatelessWidget {
  // final UserModel user;

  const BuildRowInfo({
    super.key,
    // required this.user,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              AppStrings.id,
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              '1',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        HelperMethod.verticalSpace(AppSizes.verticalSpacingS20),
        const Divider(
          thickness: 1,
          color: Colors.grey,
        ),
        HelperMethod.verticalSpace(AppSizes.verticalSpacingS20),
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
             Text(
              AppStrings.email,
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'email',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        HelperMethod.verticalSpace(AppSizes.verticalSpacingS20),
        const Divider(
          thickness: 1,
          color: Colors.grey,
        ),
        HelperMethod.verticalSpace(AppSizes.verticalSpacingS20),
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
             Text(
              AppStrings.descriptionLabel,
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'description',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        HelperMethod.verticalSpace(AppSizes.verticalSpacingS20),
        const Divider(
          thickness: 1,
          color: Colors.grey,
        ),
        HelperMethod.verticalSpace(AppSizes.verticalSpacingS20),
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              AppStrings.addressLabel,
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'address',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        HelperMethod.verticalSpace(AppSizes.verticalSpacingS20),
        const Divider(
          thickness: 1,
          color: Colors.grey,
        ),
        HelperMethod.verticalSpace(AppSizes.verticalSpacingS20),
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
             Text(
              AppStrings.passwordLabel,
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'password',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
