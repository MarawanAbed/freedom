import 'package:flutter/material.dart';
import 'package:freedom_chat_app/core/di/dependancy_injection.dart';
import 'package:freedom_chat_app/freedom/home/domain/use_case/update_user.dart';
import 'package:freedom_chat_app/freedom/home/presentation/widgets/home_body.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with WidgetsBindingObserver {
  @override
  void initState() {
    getIt<UpdateUserUseCase>().call({
      'lastActive': DateTime.now(),
      'isOnline': true,
    });
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    if (state == AppLifecycleState.resumed) {
      getIt<UpdateUserUseCase>().call({
        'lastActive': DateTime.now(),
        'isOnline': true,
      });
    } else {
      getIt<UpdateUserUseCase>().call({
        'isOnline': false,
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return const HomeBody();
  }
}
