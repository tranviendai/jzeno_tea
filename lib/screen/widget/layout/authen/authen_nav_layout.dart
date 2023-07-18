import 'package:flutter/material.dart';
import 'package:jzeno_tea/app/constants/app_constant.dart';
import 'package:jzeno_tea/screen/widget/layout/authen/signin/signin_page.dart';
import 'package:jzeno_tea/screen/widget/layout/authen/signup/signup_page.dart';

class AuthenLayout extends StatefulWidget {
  const AuthenLayout({super.key});

  @override
  State<AuthenLayout> createState() => _AuthenLayoutState();
}

class _AuthenLayoutState extends State<AuthenLayout> {
  int _selectedIndex = 0;
  
  final List<Widget> widgetOptions = const [
    SignInPage(),
    SignUpPage(),
  ];
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        showSelectedLabels: true,
        items: [
          BottomNavigationBarItem(icon: const Icon(Icons.person), label: AppText.signInText),
          BottomNavigationBarItem(icon: const Icon(Icons.person_add), label: AppText.signUpText),
        ],
        onTap: _onItemTapped,
        currentIndex: _selectedIndex,
      ),
      body: widgetOptions[_selectedIndex]
    );
  }
}