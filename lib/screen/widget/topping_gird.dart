import 'package:flutter/material.dart';
import 'package:jzeno_tea/app/constants/app_constant.dart';
import 'package:jzeno_tea/app/data/repository/api/api.dart';
import 'package:jzeno_tea/app/model/topping_model.dart';

Widget girdToppings(List<ToppingModel> toppings) {
  String path = "${API().baseUrl}/images/";
  return ListView.builder(
      padding: EdgeInsets.zero,
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      shrinkWrap: true,
      itemCount: toppings.length,
      itemBuilder: (context, index) {
        var topping = toppings[index];
        return Container(
            margin: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.circular(20)
            ),
            width: 150,
            child: Column(children: [
              Image.network(
                path + topping.image!,
                height: 150,
              ),
              Container(
                  alignment: Alignment.center,
                  child: Text(
                    topping.name!,
                    style: AppText.h2.copyWith(fontSize: 17),
                  ))
            ]));
      });
}
