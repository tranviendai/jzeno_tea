// ignore_for_file: prefer_interpolation_to_compose_strings, prefer_const_declarations

import 'package:jzeno_tea/app/data/repository/api/api.dart';

class AppImage{
  static final String imagePath = "assets/images/";

  static final String bgMilkTea = imagePath + "bg_milk_tea.png";
  static final String logo = imagePath + "logoJZ.png";
  static final String path = "${API().baseUrl}/images/";
}