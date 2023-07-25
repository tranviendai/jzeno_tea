import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jzeno_tea/app/constants/app_constant.dart';
import 'package:jzeno_tea/app/data/bloc/auth/auth_cubit.dart';
import 'package:jzeno_tea/app/data/bloc/product/product_cubit.dart';
import 'package:jzeno_tea/app/data/bloc/product/product_state.dart';
import 'package:jzeno_tea/app/data/repository/repository.dart';
import 'package:jzeno_tea/app/model/product_model.dart';
import 'package:jzeno_tea/screen/widget/dialog/new_product.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController searchController = TextEditingController();
  double idWidth = 50;
  double cateogryWidth = 80;
  double imageWidth = 80;
  double nameWith = 150;
  double priceWith = 50;
  double descriptionWith = 350;
  List<ProductModel> listProduct = [];
  List<ProductModel> products = [];
  @override
  void initState() {
    if(listProduct.isEmpty){
      refresh();
    }
    super.initState();
  }

  Future refresh() async {
    Timer(const Duration(seconds: 1), () {
      context.read<ProductCubit>().fetchProducts();
      listProduct = ProductCubit.products.reversed.toList();
      products = listProduct;
    });
  }

  void searchProduct(String value) {
    List<ProductModel> res = [];
    if (value.isEmpty) {
       res = listProduct;
    } else {
      res = listProduct
          .where((element) =>
              element.name!.toLowerCase().contains(value.toLowerCase()))
          .toList();
    }
    setState(() {
      products = res;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body:
        BlocBuilder<ProductCubit, ProductState>(builder: (context, state) {
      return SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (context) => AlertProduct(
                                  title: AppText.newProductText,
                                ));
                      },
                      child: Text(AppText.newProductText)),
                  Container(
                    height: 60,
                    width: 400,
                    margin: const EdgeInsets.symmetric(horizontal: 10,vertical: 3),
                    child: TextField(
                      onChanged: (value) => searchProduct(value),
                      decoration: InputDecoration(
            fillColor: Theme.of(context).primaryColor,
            filled: true,
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 1),
                borderRadius: BorderRadius.circular(10)),
            enabledBorder: OutlineInputBorder(borderSide: BorderSide.none),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            hintText: "Search",
            hintStyle: TextStyle(color: Theme.of(context).hintColor),
            prefixIcon: Icon(Icons.search, color: Theme.of(context).hintColor))
                    ),
                  )
                ],
              ),
             products.isNotEmpty ? Column(children: [
              Wrap(
                alignment: WrapAlignment.spaceBetween,
                children: [
                  textLabel("", imageWidth),
                  textLabel(AppText.idText, idWidth -10),
                  textLabel(AppText.categoryText, cateogryWidth),
                  textLabel(AppText.nameText, nameWith),
                  textLabel(AppText.priceText, priceWith),
                  textLabel(AppText.descriptionText, descriptionWith),
                  const SizedBox(
                    width: 150,
                  ),
                  Container()
                ],
              ),
              ListView.builder(
                primary: false,
                shrinkWrap: true,
                itemCount: products.length,
                itemBuilder: (context, index) {
                  var product = products[index];
                  return InkWell(
                    onTap: () {},
                    child: Container(
                        margin: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            color: index.isOdd
                                ? Theme.of(context).primaryColor
                                : Theme.of(context).cardColor,
                            borderRadius: BorderRadius.circular(10)),
                        child: Wrap(
                          alignment: WrapAlignment.spaceBetween,
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: [
                            SizedBox(
                              width: imageWidth,
                              height: imageWidth,
                              child: Image(
                                image: NetworkImage(
                                    AppImage.path + product.image!),
                                fit: BoxFit.fill,
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(left: 8),
                              child: SizedBox(
                                width: idWidth,
                                child: Text("#${product.id!}"),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(left: 8),
                              child: SizedBox(
                                width: cateogryWidth,
                                child: Text("${product.categoryID!}"),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.symmetric(horizontal: 8),
                              child: SizedBox(
                                width: nameWith,
                                child: Text(
                                  product.name!.length > 50
                                      ? "${product.name!.substring(0, 50)}..."
                                      : product.name!,
                                  textAlign: TextAlign.start,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: priceWith,
                              child: Text(
                                "\$${product.price!.toStringAsPrecision(3)}",
                                style: AppText.h2.copyWith(fontSize: 16),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.symmetric(horizontal: 8),
                              child: SizedBox(
                                  height: 80,
                                  width: descriptionWith,
                                  child: Container(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      product.description!.length > 150
                                          ? "${product.description!.substring(0, 150)}..."
                                          : product.description!,
                                    ),
                                  )),
                            ),
                            Wrap(
                              children: [
                                IconButton(
                                    onPressed: () {
                                      showDialog(
                                          context: context,
                                          builder: (context) => AlertProduct(
                                                product: product,
                                                title:
                                                    AppText.updateProductText,
                                              ));
                                    },
                                    icon: const Icon(Icons.edit)),
                                IconButton(
                                    onPressed: () {
                                      showDialog(
                                          context: context,
                                          builder: (context) => AlertDialog(
                                                title: Text(
                                                    "Delete '#${product.id}'"),
                                                content: const Text(
                                                    "Are you sure to do this?"),
                                                actions: [
                                                  TextButton(
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    },
                                                    child: const Text("Cancel"),
                                                  ),
                                                  TextButton(
                                                      onPressed: () {
                                                        context
                                                            .read<
                                                                ProductCubit>()
                                                            .removeProduct(
                                                                product.id!);
                                                        Navigator.of(context)
                                                            .popAndPushNamed(
                                                                "Home");
                                                      },
                                                      child:
                                                          const Text("Accept"))
                                                ],
                                              ));
                                    },
                                    icon: const Icon(Icons.delete)),
                              ],
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                          ],
                        )),
                  );
                },
              ),
             ],): SizedBox(height: MediaQuery.of(context).size.height/1.1, child: Center(child: CircularProgressIndicator()))
            ] ,
          ),
        ),
      );
    }));
  }

  Widget textLabel(String text, double width) {
    return SizedBox(
      width: width,
      child: Center(
          child:
              Text(text, style: const TextStyle(fontWeight: FontWeight.bold))),
    );
  }
}
