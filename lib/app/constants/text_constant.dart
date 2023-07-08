// ignore_for_file: prefer_const_declarations, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppText {
  static final String welcomeHeader = "JZeno";
  static final String started = "GET STARTED";
  static final String homeText = "Home";
  static final String notificationText = "Notification";
  static final String meText = "Me";
  static final String editProfile = "Edit Profile";
  static final String myVoucherText = "My Vouchers";
  static final String myPurchaseText = "My Purchases";
  static final String signinText = "Sign in";
  static final String signupText = "Sign up";
  static final String logoutText = "Log out";
  static final String phoneNumberText = "Phone number";
  static final String fullname = "Full Name";
  static final String passText = "Password";
  static final String themeSystemText = "Change Theme";
  static final String languageSystemText = "Change Language";
  static final String regulationText01 = "Become JZeno Partner";
  static final String regulationText02 = "Terms of Service";
  static final String confirmPassText = "Confirm Password";
  static final String forgotPassText = "Forgot Password?";
  static final String fbText = "Continue With Facebook";
  static final String ggText = "Continue With Google";
  static final String userName = "Username";
  static final String categoryText = "Category";
  static final String shirtText = "Shirts";
  static final String shoesText = "Shoes";
  static final String sandalText = "Sandal";
  static final String trouserText = "Trousers";
  static final String addToCartText = "Add to Cart";
  static final String seeallText = "See All";
  static final String addImageText = "Add Image";
  static final String descriptionText ="Description";
  static final String idText = "ID";
  static final String nameText ="Name";
  static final String sizeText = "Size";
  static final String colorText = "Color";
  static final String quantityText = "Quantity";
  static final String discountText = "Discount";
  static final String materialText ="Material";
  static final String priceText = "Price";
  static final String newColorText = "New Color";
  static final String updateColorText = "Update Color";
  static final String newProductText = "New Product";
  static final TextStyle h1 = TextStyle(fontSize: 32, fontWeight: FontWeight.bold);
  static final TextStyle h2 = TextStyle(fontSize: 28);
  static final TextStyle h3 = TextStyle(fontSize: 24);
  static final TextStyle webH2 = TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold);


  static Widget textButton(String text, Color color){
    return Container(
      margin: const EdgeInsets.all(3),
      padding:const  EdgeInsets.all(5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: color
      ),
      child: Text(text,style: TextStyle(color: Colors.white, fontSize: 14),),
    );
  }
  static Widget textFiled(BuildContext context,
      TextEditingController controller, String text, IconData icon,
      {TextCapitalization? format,
      bool? obscure,
      Function(BuildContext context)? showPass}) {
    return Container(
      padding: EdgeInsets.only(top: 6,bottom: 6),
      child: TextField(
        maxLines: text == AppText.descriptionText ? null : 1,
        style: TextStyle(color: Colors.black),
        inputFormatters: [
          text == AppText.discountText || text == AppText.priceText || text == AppText.quantityText ? FilteringTextInputFormatter.digitsOnly : FilteringTextInputFormatter.singleLineFormatter
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
            fillColor: Color.fromARGB(255, 240, 240, 240),
            filled: true,
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black, width: 1),
                borderRadius: BorderRadius.circular(10)),
            enabledBorder: OutlineInputBorder(borderSide: BorderSide.none),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            hintText: text,
            hintStyle: TextStyle(color: Colors.black),
            prefixIcon: Icon(icon, color: Colors.black)),
      ),
    );
  }
}
