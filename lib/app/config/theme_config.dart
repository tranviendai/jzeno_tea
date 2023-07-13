import 'package:flutter/material.dart';
import 'package:jzeno_tea/app/constants/app_constant.dart';

class AppTheme {
  static ThemeData  lightTheme = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: AppColor.scafflodBgColor,
    cardColor: AppColor.grey50Color,
    primaryColor: Colors.white,
    textTheme: TextTheme(
      headlineLarge: AppText.h1.copyWith(color: Colors.black),
      headlineMedium: AppText.h2.copyWith(color: Colors.black),
      headlineSmall: AppText.h3.copyWith(color: Colors.black),
    ),
  );
  static ThemeData blackTheme = ThemeData(
    brightness: Brightness.dark,
    cardColor: Colors.black12,
    primaryColor: const Color.fromARGB(115, 90, 90, 90),
    appBarTheme:  AppBarTheme(color: const Color.fromARGB(255, 37, 37, 37),titleTextStyle: AppText.h0.copyWith(color: Colors.white)),
    textTheme: TextTheme(
      headlineLarge: AppText.h1.copyWith(color: Colors.white),
      headlineMedium: AppText.h2.copyWith(color: Colors.white),
      headlineSmall: AppText.h3.copyWith(color: Colors.white),
    ),
  );

}
