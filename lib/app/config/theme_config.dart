import 'package:flutter/material.dart';
import 'package:jzeno_tea/app/constants/app_constain.dart';

class AppTheme {
  static ThemeData  lightTheme = ThemeData(
    brightness: Brightness.light,
    cardColor: Colors.white,
    primaryColor: Colors.white,
    textTheme: TextTheme(
      headlineLarge: AppText.h1.copyWith(color: Colors.black),
      headlineMedium: AppText.h2.copyWith(color: Colors.black),
      headlineSmall: AppText.h3.copyWith(color: Colors.black),
    ),
  );
  static ThemeData blackTheme = ThemeData(
    brightness: Brightness.dark,
    cardColor: Colors.black26,
    primaryColor: Colors.black26,
    textTheme: TextTheme(
      headlineLarge: AppText.h1.copyWith(color: Colors.white),
      headlineMedium: AppText.h2.copyWith(color: Colors.white),
      headlineSmall: AppText.h3.copyWith(color: Colors.white),
    ),
  );
}
