import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:freedom_chat_app/core/routes/app_routes.dart';
import 'package:freedom_chat_app/core/routes/routes.dart';

class Freedom extends StatelessWidget {
  const Freedom({super.key, required this.isOnBoarding});

  final bool isOnBoarding;

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Freedom Chat',
        theme: ThemeData.light(),
        darkTheme: ThemeData.dark(),
        themeMode: ThemeMode.system,
        routes: AppRoutes.routes,
        initialRoute: Routes.editProfilePage,
      ),
    );
  }
}
