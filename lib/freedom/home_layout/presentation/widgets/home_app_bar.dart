import 'package:flutter/material.dart';
import 'package:freedom_chat_app/core/di/dependancy_injection.dart';
import 'package:freedom_chat_app/core/helpers/extension.dart';
import 'package:freedom_chat_app/core/helpers/helper_methods.dart';
import 'package:freedom_chat_app/core/routes/routes.dart';
import 'package:freedom_chat_app/core/themes/styles.dart';
import 'package:freedom_chat_app/core/utils/sizes.dart';
import 'package:freedom_chat_app/freedom/home_layout/domain/repo/repo.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      automaticallyImplyLeading: false,
      title: Padding(
        padding: EdgeInsets.only(left: AppSizes.kDefaultAllPaddingS10),
        child: Text(
          'Freedom',
          style: TextStyles.font22Bold,
        ),
      ),
      actions: [
        IconButton(
          onPressed: () {
            context.pushNamed(Routes.searchPage);
          },
          icon: Icon(
            Icons.search,
            size: AppSizes.iconSizeS30,
          ),
        ),
        HelperMethod.horizontalSpace(AppSizes.horizontalSpacingS15),
        IconButton(
          onPressed: () {
            getIt<HomeLayoutRepo>().logout().then((_) {
              context.pushNamedAndRemoveUntil(Routes.authPage,
                  predicate: (route) => false);
            });
          },
          icon: Icon(
            Icons.logout,
            size: AppSizes.iconSizeS30,
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
