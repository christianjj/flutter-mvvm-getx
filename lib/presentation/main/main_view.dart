import 'package:flutter/material.dart';
import 'package:flutter_restapi/presentation/main/home/home_page.dart';
import 'package:flutter_restapi/presentation/main/notifications_page.dart';
import 'package:flutter_restapi/presentation/main/search_page.dart';
import 'package:flutter_restapi/presentation/main/settings_page.dart';
import 'package:flutter_restapi/presentation/resources/color_manager.dart';
import 'package:flutter_restapi/presentation/resources/values_manager.dart';

import '../resources/strings_manager.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  List<Widget> pages = [
    const HomePage(),
    const SearchPage(),
    const NotificationPage(),
    const SettingsPage()
  ];

  List<String> titles = [
    AppStrings.home,
    AppStrings.search,
    AppStrings.notification,
    AppStrings.settings
  ];

  var _title = AppStrings.home;
  var _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(_title, style: Theme.of(context).textTheme.titleMedium)),
      body: pages[_currentIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(color: ColorManager.black, spreadRadius: AppSize.s1)
        ]),
        child: BottomNavigationBar(
          selectedItemColor: ColorManager.primary,
          unselectedItemColor: ColorManager.grey,
          currentIndex: _currentIndex,
          onTap: onTap,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: AppStrings.home),
            BottomNavigationBarItem(icon: Icon(Icons.search), label: AppStrings.search),
            BottomNavigationBarItem(icon: Icon(Icons.notifications), label: AppStrings.notification),
            BottomNavigationBarItem(icon: Icon(Icons.settings), label: AppStrings.settings),
          ],
        ),
      ),
    );
  }

  onTap(int index) {
    setState(() {
      _currentIndex = index;
      _title = titles[index];
    });
  }
}
