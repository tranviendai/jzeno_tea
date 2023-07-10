import 'package:flutter/material.dart';
import 'package:jzeno_tea/app/constants/app_constant.dart';

class AppPrice{
  double productPrice(double price,int discount) => price - price * (discount/100);
  Widget richText(double price, int discount){
    return RichText(text: TextSpan(
      children: [
        TextSpan(text: "\$${productPrice(price,discount).toStringAsPrecision(3)} ",
                    style: AppText.h0.copyWith(
                        color: Colors.red, fontWeight: FontWeight.bold),),
       if(discount != 0) TextSpan(text: "\$$price", style: AppText.h1.copyWith(fontWeight: FontWeight.bold,decoration: TextDecoration.lineThrough, color: Colors.grey))
      ],
    ));
  }
}