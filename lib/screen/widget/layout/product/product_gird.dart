import 'package:flutter/material.dart';
import 'package:jzeno_tea/app/constants/app_constant.dart';
import 'package:jzeno_tea/app/extension/responsive_extention.dart';
import 'package:jzeno_tea/app/model/product_model.dart';
import 'package:jzeno_tea/screen/mobile_responsive/product/detail_screen.dart';

class LayoutGirdProduct extends StatefulWidget {
  final List<ProductModel> products;
  const LayoutGirdProduct({super.key, required this.products});

  @override
  State<LayoutGirdProduct> createState() => _LayoutGirdProductState();
}

class _LayoutGirdProductState extends State<LayoutGirdProduct> {
  @override
  Widget build(BuildContext context) {
    var products = widget.products;
    double ratioMobile = MediaQuery.of(context).size.width /
        MediaQuery.of(context).size.height /
        1;
    double ratioTablet = MediaQuery.of(context).size.width /
        MediaQuery.of(context).size.height /
        1.7;
    return Responsive(
        mobile: GridView.builder(
            shrinkWrap: true,
            itemCount: products.length,
            padding: EdgeInsets.zero,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: ratioMobile,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10),
            itemBuilder: (context, index) {
              var product = products[index];
              return InkWell(
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProductDetail(product: product),
                      )),
                  child: bodyGird(context, product, 30));
            }),
        tablet: GridView.builder(
            shrinkWrap: true,
            itemCount: products.length,
            padding: EdgeInsets.zero,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: ratioTablet,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10),
            itemBuilder: (context, index) {
              var product = products[index];
              return InkWell(
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProductDetail(product: product),
                      )),
                  child: bodyGird(context, product, 60));
            }));
  }

  Widget bodyGird(BuildContext context, ProductModel product, int nameLenght) {
    return Container(
        padding: const EdgeInsets.all(5),
        margin: const EdgeInsets.all(5),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: Theme.of(context).primaryColor),
        child: Stack(
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
            Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 30),
                    child: Image.network(
                      AppImage.path + product.image!,
                      height: MediaQuery.of(context).size.height / 4.5,
                    ),
                  ),
                  AppText.textAlignLeft(Text(
                    maxLines: 2,
                    product.name!.length > nameLenght
                        ? "${product.name!.substring(0, nameLenght)}..."
                        : product.name!,
                    style: AppText.h1,
                  )),
                  Container(
                      alignment: Alignment.topRight,
                      margin: const EdgeInsets.symmetric(
                          horizontal: 5, vertical: 3),
                      child: Text(
                        "\$${AppPrice().productPrice(product.price!, product.discount!).toStringAsPrecision(3)}",
                        style: AppText.h1.copyWith(color: Colors.red),
                      )),
                ]),
          ],
        ));
  }
}
