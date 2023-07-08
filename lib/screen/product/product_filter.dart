import 'package:flutter/material.dart';
import 'package:jzeno_tea/app/constants/app_constain.dart';
import 'package:jzeno_tea/app/data/repository/api/api.dart';
import 'package:jzeno_tea/app/model/product_model.dart';

class ProductFilter extends StatefulWidget {
  final String title;
  final List<ProductModel>? products;
  const ProductFilter({super.key, required this.products,required this.title});

  @override
  State<ProductFilter> createState() => _ProductFilterState();
}

class _ProductFilterState extends State<ProductFilter> {
  @override
  Widget build(BuildContext context) {
    String path = "${API().baseUrl}/images/";
    double heightItem = 125;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: Icon(Icons.arrow_back_ios), onPressed: (){ Navigator.pop(context);},),
        title: Text(widget.title),
        actions: [
          IconButton(onPressed: (){}, icon: Icon(Icons.search)),
          IconButton(onPressed: (){}, icon: Icon(Icons.sort))
        ],
      ),
      body: ListView.builder(
          itemCount: widget.products!.length,
          padding: EdgeInsets.zero,
          itemBuilder: (context, index) {
            var product = widget.products![index];
            return Container(
              height: heightItem,
              padding: const EdgeInsets.all(5),
              margin: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5), color: Colors.white),
              child: InkWell(
                onTap: () {},
                child: Stack(
                  children: [
                    product.discount != 0
                        ? Positioned(
                            bottom: 0,
                            right: 0,
                            child: Container(
                              padding: const EdgeInsets.all(5),
                              color: Colors.amberAccent,
                              alignment: Alignment.center,
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Expanded(
                            flex: 1,
                            child: Container(
                              height: heightItem,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image:
                                          NetworkImage(path + product.image!)),
                                  borderRadius: BorderRadius.circular(5)),
                            )),
                        SizedBox(
                          width: 30,
                          height: 10,
                        ),
                        Expanded(
                            flex: 2,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  alignment: Alignment.topLeft,
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 3),
                                  child: Text(
                                    product.name!.length > 45
                                        ? "${product.name!.substring(0, 45)}..."
                                        : product.name!,
                                    style: AppText.h1,
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.topLeft,
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 3),
                                  child: Text(
                                    "\$${product.price!}",
                                    style: AppText.h2.copyWith(
                                        color: Colors.red,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ))
                      ],
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }
}
