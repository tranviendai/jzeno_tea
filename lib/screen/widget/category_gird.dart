import 'package:flutter/material.dart';
import 'package:jzeno_tea/app/constants/app_constant.dart';
import 'package:jzeno_tea/app/data/repository/api/api.dart';
import 'package:jzeno_tea/app/model/category_model.dart';
import 'package:jzeno_tea/screen/mobile_responsive/product/product_filter_screen.dart';

Widget girdCategories(List<CategoryModel> categories) {
  String path = "${API().baseUrl}/images/";
  return Center(
    child: ListView.builder(
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
                  margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width / MediaQuery.of(context).size.height / 2),
                  width: 75,
                  child: Column(children: [
                    Image.network(
                      path + category.icon!,
                      height: 38,
                    ),
                    Container(
                        margin: const EdgeInsets.all(3),
                        alignment: Alignment.center,
                        child: Text(
                          category.name!,
                          style: AppText.h2.copyWith(fontSize: 16),
                        ))
                  ])));
        }),
  );
}
