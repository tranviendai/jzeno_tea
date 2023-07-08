import 'package:flutter/material.dart';
import 'package:jzeno_tea/app/constants/app_constain.dart';
import 'package:jzeno_tea/app/data/repository/api/api.dart';
import 'package:jzeno_tea/app/model/product_model.dart';

Widget girdProduct(List<ProductModel> products) {
  String path = "${API().baseUrl}/images/";
  return GridView.builder(
      shrinkWrap: true,
      itemCount: products.length,
      padding: EdgeInsets.zero,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, childAspectRatio: 0.6),
      itemBuilder: (context, index) {
        var product = products[index];
        return InkWell(
          onTap: () {},
          child: Container(
              padding: const EdgeInsets.all(5),
              margin: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5), color: Colors.white),
              child: Column(children: [
                Stack(
                  children: [
                    product.discount != 0
                        ? Positioned(
                            top: 0,
                            left: 0,
                            child: Container(
                              padding: const EdgeInsets.all(5),
                              color: Colors.amberAccent,
                              alignment: Alignment.topCenter,
                              child: RichText(
                                text: TextSpan(children: [
                                  TextSpan(
                                      text: "\$${product.discount} ",
                                      style: AppText.h2.copyWith(
                                          color: Colors.red,
                                          fontWeight: FontWeight.bold)),
                                  TextSpan(
                                      text: "OFF",
                                      style: AppText.h2.copyWith(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold))
                                ]),
                              ),
                            ))
                        : Container(),
                    Container(
                      margin: const EdgeInsets.only(top: 30),
                      child: Image.network(
                        path + product.image!,
                        height: 180,
                      ),
                    ),
                  ],
                ),
                Container(
                  alignment: Alignment.topLeft,
                  margin:
                      const EdgeInsets.symmetric(horizontal: 5, vertical: 3),
                  child: Text(
                    maxLines: 2,
                    product.name!.length > 30
                        ? "${product.name!.substring(0, 30)}..."
                        : product.name!,
                    style: AppText.h1,
                  ),
                ),
                Container(
                  alignment: Alignment.topLeft,
                  margin:
                      const EdgeInsets.symmetric(horizontal: 5, vertical: 3),
                  child: Text(
                    "\$${product.price!}",
                    style: AppText.h2.copyWith(
                        color: Colors.red, fontWeight: FontWeight.bold),
                  ),
                ),
              ])),
        );
      });
}
