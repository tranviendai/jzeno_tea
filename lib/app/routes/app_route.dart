import 'package:flutter/material.dart';
import 'package:jzeno_tea/app/extension/responsive_extention.dart';
import 'package:jzeno_tea/screen/widget/layout/authen/signin/signin_page.dart';
import 'package:jzeno_tea/screen/widget/layout/authen/signup/signup_page.dart';
import 'package:jzeno_tea/screen/widget/nav/bottom_nav.dart';
import 'package:jzeno_tea/screen/mobile_responsive/cart/cart_screen.dart';
import 'package:jzeno_tea/screen/mobile_responsive/home/home_screen.dart' as mobile;
import 'package:jzeno_tea/screen/desktop_responsive/home/home_screen.dart' as desktop;
import 'package:jzeno_tea/screen/widget/nav/drawer_nav.dart';

class AppRoute {
  static Route onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const Responsive(mobile: TabMobile(), tablet: TabMobile(), desktop: TabDesktop()));
      case 'Home':
        return MaterialPageRoute(builder: (_) => const Responsive(mobile: mobile.HomeScreen(), tablet: mobile.HomeScreen(), desktop: desktop.HomeScreen()));
         case 'Cart':
        return MaterialPageRoute(builder: (_) => const Responsive(mobile: CartScreen(), tablet: CartScreen(), desktop: CartScreen()));
       case 'SignIn':
        return MaterialPageRoute(builder: (_) => const Responsive(mobile: SignInPage(), tablet: SignInPage(), desktop: SignInPage()));
        case 'SignUp':
        return MaterialPageRoute(builder: (_) => const Responsive(mobile: SignUpPage(), tablet: SignUpPage(), desktop: SignUpPage()));
    default:
        return MaterialPageRoute(builder: (_) => const Responsive(mobile: TabMobile(), tablet: TabMobile(), desktop: TabDesktop()));
    }
  }
}
