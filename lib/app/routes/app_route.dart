import 'package:flutter/material.dart';
import 'package:jzeno_tea/screen/bottom_nav.dart';
import 'package:jzeno_tea/screen/home/home_screen.dart';

class AppRoute {
  static Route onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const TabMobile());
      case 'Home':
        return MaterialPageRoute(builder: (_) => const HomeScreen());
    default:
        return MaterialPageRoute(builder: (_) => const TabMobile());
    }
  }
}
