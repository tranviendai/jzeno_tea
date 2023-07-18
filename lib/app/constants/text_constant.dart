// ignore_for_file: prefer_const_declarations, prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  static final String logoutText = "Logout";
  static final String signInText = "SignIn";
  static final String fullname ="FullName";
    static final String userName = "Username";
  static final String signUpText = "SignUp";
    static final String confirmPassText = "Confirm Password";
  static final String forgotPassText = "Forgot Password?";
  static final String fontFamily = "rubik";
  static final String fontFamilyBold = "rubikB";
    static final String fbText = "Continue With Facebook";
  static final String ggText = "Continue With Google";
    static final String idText = "ID";
  static final String nameText = "Name";
  static final String settingText = "Setting";
  static final String notify01 =
      "This product is out of stock, please choose another product... ";
  static final String notify02 = "No extras dishes...";
  static final String notify03 = "No cart empty...";
  static final String descriptionText = "Description";

  static final String discountText = "Discount";
  static final String priceText = "Price";
  static final String passText = "Password";

  static final TextStyle h0 = TextStyle(
      fontFamily: fontFamilyBold, fontSize: 25, fontWeight: FontWeight.bold);
  static final TextStyle h1 = TextStyle(
      fontFamily: fontFamilyBold, fontSize: 20, fontWeight: FontWeight.bold);
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

  static Widget textAlignLeft(Widget text) {
    return Container(
        alignment: Alignment.centerLeft,
        margin: const EdgeInsets.only(top: 10),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 3),
        child: text);
  }

  static Widget textFiled(BuildContext context,
      TextEditingController controller, String text, IconData icon,
      {TextCapitalization? format,
      bool? obscure,
      Function(BuildContext context)? showPass}) {
    return Container(
      padding: EdgeInsets.only(top: 6, bottom: 6),
      child: TextField(
        maxLines: text == AppText.descriptionText ? null : 1,
        style: TextStyle(color: Theme.of(context).hintColor),
        inputFormatters: [
          text == AppText.discountText || text == AppText.priceText
              ? FilteringTextInputFormatter.digitsOnly
              : FilteringTextInputFormatter.singleLineFormatter
        ],
        controller: controller,
        obscureText: text == AppText.passText ? obscure! : false,
        decoration: InputDecoration(
            suffixIcon: text == AppText.passText
                ? IconButton(
                    icon: Icon(
                        obscure! ? Icons.visibility : Icons.visibility_off),
                    onPressed: () {
                      showPass!(context);
                    },
                  )
                : null,
            fillColor: Theme.of(context).primaryColor,
            filled: true,
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 1),
                borderRadius: BorderRadius.circular(10)),
            enabledBorder: OutlineInputBorder(borderSide: BorderSide.none),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            hintText: text,
            hintStyle: TextStyle(color: Theme.of(context).hintColor),
            prefixIcon: Icon(icon, color: Theme.of(context).hintColor)),
      ),
    );
  }
}
