import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:freedom_chat_app/core/utils/sizes.dart';
import 'package:freedom_chat_app/freedom/sign_in/presentation/bloc/sign_in_cubit.dart';

import '../../../../../core/helpers/helper_methods.dart';
import 'logo_button.dart';

class BuildRowLogo extends StatelessWidget {
  const BuildRowLogo({
    super.key,
  });


  @override
  Widget build(BuildContext context) {
    var cubit=context.read<SignInCubit>();
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        LogoButton(
          icon: FontAwesomeIcons.google,
          color: Colors.red,
          onPressed: () async{
            await cubit.signInWithGoogle();
          },
        ),
        HelperMethod.horizontalSpace(AppSizes.horizontalSpacingS10),
        LogoButton(
          icon: FontAwesomeIcons.twitter,
          color: Colors.blue,
          onPressed: () async{
            await cubit.signInWithTwitter();

          },
        ),
        HelperMethod.horizontalSpace(AppSizes.horizontalSpacingS10),
        LogoButton(
          onPressed: () async{
            await cubit.signInWithGithub(context);
          },
          icon: FontAwesomeIcons.github,
          color: Colors.grey,
        ),
      ],
    );
  }
}