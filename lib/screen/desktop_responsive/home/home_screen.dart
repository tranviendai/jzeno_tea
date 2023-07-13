import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jzeno_tea/app/constants/app_constant.dart';
import 'package:jzeno_tea/app/data/bloc/product/product_cubit.dart';
import 'package:jzeno_tea/app/data/bloc/product/product_state.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController searchProducts = TextEditingController();

  @override
  Widget build(BuildContext context) {
  double idWidth = 80;
  double imageWidth = 80;
  double nameWith = 200;
  double priceWith = 50;
  double descriptionWith = 350;
    return Scaffold(body:
        BlocBuilder<ProductCubit, ProductState>(builder: (context, state) {
      if (state is ProductsLoaded) {
        var products = state.products;
        if (products.isEmpty) {
          return Center(
            child: TextButton(
                onPressed: () {
                  // showDialog(context: context, builder: (context) => const AlertProduct());
                },
                child: const Text("New Product?")),
          );
        } else {
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
                            // showDialog(context: context, builder: (context) => const AlertProduct());
                          },
                          child: const Text("New Product?")),
                      Container(
                        height: 60,
                        width: 400,
                        margin: const EdgeInsets.symmetric(horizontal: 10),
                        child: AppText.textFiled(
                            context, searchProducts, "Search", Icons.search),
                      )
                    ],
                  ),
                  Wrap(
                    alignment: WrapAlignment.spaceBetween,
                    children: [
                      textLabel("", imageWidth + 5),
                      textLabel(AppText.idText,idWidth),
                      textLabel(AppText.nameText,nameWith),
                      textLabel(AppText.priceText,priceWith),
                      textLabel(AppText.descriptionText,descriptionWith),
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
                                  margin:
                                      const EdgeInsets.symmetric(horizontal: 8),
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
                                  margin:
                                      const EdgeInsets.symmetric(horizontal: 8),
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
                                          //  showDialog(context: context, builder: (context) => AlertProduct(product: product));
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
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        child: const Text(
                                                            "Cancel"),
                                                      ),
                                                      TextButton(
                                                          onPressed: () {
                                                            // context.read<ProductCubit>().removeProduct(product.id!);
                                                            Navigator.of(
                                                                    context)
                                                                .popAndPushNamed(
                                                                    "Tab_Tablet");
                                                          },
                                                          child: const Text(
                                                              "Accept"))
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
                ],
              ),
            ),
          );
        }
      }
      return const Center(
        child: CircularProgressIndicator(
          color: Colors.black,
        ),
      );
    }));
  }

  Widget textLabel(String text,double width) {
    return SizedBox(
      width: width,
      child: Text(text, style: TextStyle(fontWeight: FontWeight.bold)),
    );
  }
}
