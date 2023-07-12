// ignore_for_file: prefer_const_declarations, prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:jzeno_tea/app/constants/app_constant.dart';

class AppText {
  static final String welcomeHeader = "JZeno";
  static final String titleApp = "JZTea";
  static final String started = "GET STARTED";
  static final String homeText = "Home";
  static final String meText = "Setting";
  static final String cartText = "Cart";
  static final String myCartText = "My Cart";
  static final String addtoCartText = "Add To Cart".toUpperCase();
  static final String editProfile = "Edit Profile";
  static final String themeSystemText = "Change Color";
  static final String logoutText= "Logout";
  static final String fontFamily = "rubik";
  static final String fontFamilyBold = "rubikB";
  static final String notify01 = "This product is out of stock, please choose another product... ";
    static final String notify02 = "No extras dishes...";
        static final String notify03 = "No cart empty...";


  static final TextStyle h0 = TextStyle(
      fontFamily: fontFamilyBold,
      fontSize: 25,
      fontWeight: FontWeight.bold);
  static final TextStyle h1 = TextStyle(
      fontFamily: fontFamilyBold,
      fontSize: 20,
      fontWeight: FontWeight.bold);
  static final TextStyle h2 = TextStyle(fontFamily: fontFamily, fontSize: 18);
  static final TextStyle h3 = TextStyle(
      fontFamily: fontFamily,
      fontSize: 16,
      letterSpacing: 1,
      color: AppColor.greyColor);
  static final TextStyle h4 = TextStyle(
      fontFamily: fontFamily, fontSize: 16, fontWeight: FontWeight.bold);

  static Widget textButton(String text, Color color) {
    return Container(
      margin: const EdgeInsets.all(3),
      padding: const EdgeInsets.all(5),
      decoration:
          BoxDecoration(borderRadius: BorderRadius.circular(5), color: color),
      child: Text(
        text,
        style: TextStyle(color: Colors.white, fontSize: 14),
      ),
    );
  }
  static Widget textAlignLeft(Widget text){
    return Container(
              alignment: Alignment.centerLeft,
              margin: const EdgeInsets.only(top: 10),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 3),
              child: text);
  }
}
