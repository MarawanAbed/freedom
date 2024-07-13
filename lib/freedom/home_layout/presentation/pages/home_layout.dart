import 'package:flutter/material.dart';
import 'package:freedom_chat_app/freedom/home/presentation/pages/home_page.dart';
import 'package:freedom_chat_app/freedom/home_layout/presentation/widgets/app_bar_custom.dart';
import 'package:freedom_chat_app/freedom/home_layout/presentation/widgets/bottom_navigation.dart';
import 'package:freedom_chat_app/freedom/home_layout/presentation/widgets/home_app_bar.dart';


import '../../../profile/presentation/pages/profile_page.dart';

class HomeLayout extends StatefulWidget {
  const HomeLayout({super.key});

  @override
  State<HomeLayout> createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> with WidgetsBindingObserver {
  int _currentIndex = 0;
  final List<Widget> _pages = const [
    HomePage(),
    ProfilePage(),
  ];
  final List<String> _titles = const [
    'Home',
    'Profile',
  ];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: _titles[_currentIndex] == 'Home'
            ? const HomeAppBar() as PreferredSizeWidget
            : AppBarCustom(
          title: _titles[_currentIndex],
        ),
        body: _pages[_currentIndex],
        bottomNavigationBar: CustomBottomNavigation(
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
        ),
      ),
    );
  }
}
