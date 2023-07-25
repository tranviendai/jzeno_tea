import 'package:flutter/material.dart';
import 'package:jzeno_tea/app/constants/app_constant.dart';
import 'package:jzeno_tea/screen/mobile_responsive/home/home_screen.dart';
import 'package:jzeno_tea/screen/widget/layout/setting/setting_screen.dart';

class TabMobile extends StatefulWidget {
  final String? token;
  const TabMobile({this.token,super.key});

  @override
  State<TabMobile> createState() => _TabMobileState();
}

class _TabMobileState extends State<TabMobile> {
  final PageController pageController = PageController();
  int _selectedIndex = 0;
  
  final List<Widget> widgetOptions = const [
    HomeScreen(),
    SettingScreen()
  ];
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    pageController.jumpToPage(index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: false,
        showSelectedLabels: false,
        items: [
          BottomNavigationBarItem(icon: const Icon(Icons.home), label: AppText.homeText),
          BottomNavigationBarItem(icon: const Icon(Icons.person), label: AppText.meText),
        ],
        onTap: _onItemTapped,
        currentIndex: _selectedIndex,
      ),
      body: WillPopScope(
        onWillPop: () async => false,
        child: PageView.builder(
          controller: pageController,
          itemCount: widgetOptions.length,
          allowImplicitScrolling: true,
          onPageChanged: (value) {
            _onItemTapped(value);
          },
          itemBuilder: (context, index) {
            return widgetOptions.elementAt(index);
          },
        ),
      ),
    );
  }
}
