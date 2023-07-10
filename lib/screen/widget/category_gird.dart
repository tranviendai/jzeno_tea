import 'package:flutter/material.dart';
import 'package:jzeno_tea/app/constants/app_constant.dart';
import 'package:jzeno_tea/app/data/repository/api/api.dart';
import 'package:jzeno_tea/app/model/category_model.dart';
import 'package:jzeno_tea/screen/product/product_filter_screen.dart';

Widget girdCategories(List<CategoryModel> categories) {
  String path = "${API().baseUrl}/images/";
  return ListView.builder(
      padding: EdgeInsets.zero,
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      shrinkWrap: true,
      itemCount: categories.length,
      itemBuilder: (context, index) {
        var category = categories[index];
        return InkWell(
            onTap: () => Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => ProductFilter(
                      products: category.products!,
                      title: category.name!,
                    ))),
            child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 3),
                width: 80,
                child: Column(children: [
                  Image.network(
                    path + category.icon!,
                    height: 40,
                  ),
                  Container(
                      margin: const EdgeInsets.all(3),
                      alignment: Alignment.center,
                      child: Text(
                        category.name!,
                        style: AppText.h2.copyWith(fontSize: 17),
                      ))
                ])));
      });
}
