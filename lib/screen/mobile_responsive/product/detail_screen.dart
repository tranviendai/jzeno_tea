import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jzeno_tea/app/constants/app_constant.dart';
import 'package:jzeno_tea/app/data/bloc/topping/topping_cubit.dart';
import 'package:jzeno_tea/app/data/bloc/topping/topping_state.dart';
import 'package:jzeno_tea/app/model/product_model.dart';
import 'package:jzeno_tea/app/model/topping_model.dart';
import 'package:jzeno_tea/screen/mobile_responsive/cart/addcart_bottomshet.dart';
import 'package:jzeno_tea/screen/widget/topping_gird.dart';

class ProductDetail extends StatefulWidget {
  final ProductModel product;
  const ProductDetail({super.key, required this.product});

  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  @override
  Widget build(BuildContext context) {
    List<ToppingModel> toppings = [];
    var product = widget.product;
    return Scaffold(
        appBar: AppBar(
            leading: IconButton(
                icon: const Icon(Icons.arrow_back_ios),
                onPressed: () => Navigator.of(context).pop()),
            title: Text(product.name!)),
        body: SingleChildScrollView(
          child: Column(children: [
            Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.4),
                      spreadRadius: 1,
                      blurRadius: 4,
                      offset:
                          const Offset(0, 0.5), // changes position of shadow
                    ),
                  ],
                  borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30)),
                  color: Theme.of(context).primaryColor,
                ),
                child: Container(
                  height: MediaQuery.of(context).size.height / 2,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(AppImage.path + product.image!))),
                )),
            AppText.textAlignLeft(
              Text(product.name!, style: AppText.h0, textAlign: TextAlign.left),
            ),
            AppText.textAlignLeft(
                AppPrice().richText(product.price!, product.discount!)),
            AppText.textAlignLeft(
              Text(product.description!,
                  style: AppText.h2.copyWith(fontFamily: AppText.fontFamily),
                  textAlign: TextAlign.left),
            ),
            AppText.textAlignLeft(
              Text("Topping", style: AppText.h0, textAlign: TextAlign.left),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 5),
              height: 200,
              child: BlocBuilder<ToppingCubit, ToppingState>(
                builder: (context, state) {
                  if (state is ToppingsLoaded) {
                    toppings = state.toppings;
                  }
                  return girdToppings(toppings);
                },
              ),
            )
          ]),
        ),
        bottomNavigationBar: BottomAppBar(
            child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                child: widget.product.isPublish!
                    ? Row(children: [
                        Expanded(
                          flex: 1,
                          child: IconButton(
                              onPressed:()=> Navigator.pushNamed(context, "Cart"),
                              icon: const Icon(
                                Icons.shopping_cart_sharp,
                                color: Colors.blue,
                              )),
                        ),
                        Expanded(
                            flex: 5,
                            child: ElevatedButton(
                                onPressed: () => showModalBottomSheet(
                                    context: context,
                                    isScrollControlled: true,
                                    enableDrag: true,
                                    isDismissible: true,
                                    shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(15),
                                          topRight: Radius.circular(15)),
                                    ),
                                    builder: (context) => AddCartScreen(
                                          product: product,
                                          topping: toppings,
                                        )),
                                child: Text(
                                  AppText.addtoCartText,
                                  style:
                                      AppText.h1.copyWith(color: Colors.white),
                                )))
                      ])
                    : Text(
                        AppText.notify01,
                        style: AppText.h3.copyWith(fontWeight: FontWeight.bold),
                      ))));
  }
}
