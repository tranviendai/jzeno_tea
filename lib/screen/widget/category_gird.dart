import 'package:flutter/material.dart';
import 'package:jzeno_tea/app/constants/app_constain.dart';
import 'package:jzeno_tea/app/data/repository/api/api.dart';
import 'package:jzeno_tea/app/model/category_model.dart';
import 'package:jzeno_tea/screen/product/product_filter.dart';

Widget girdCategories(List<CategoryModel> categories) {
    String path = "${API().baseUrl}/images/";
  return ListView.builder(
    padding: EdgeInsets.zero,
    scrollDirection: Axis.horizontal,
    shrinkWrap: true,
    itemCount: categories.length,
    itemBuilder: (context, index) {
      var category = categories[index];
      return Material(
        child: InkWell(
          onTap: (){
           Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => ProductFilter(
                            products: category.products!,title: category.name!,
                          )));
          },
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 18.5),
            child: Column(
              children: [
                Image.network(path + category.icon!,height: 40,),
                Container(
                  margin: const EdgeInsets.all(3),
                  alignment: Alignment.center,
                  child: Text(category.name!,style: AppText.h2.copyWith(fontSize: 17),)
                )
              ],
            ),
          ),
        ),
      );
    },
  );
}
