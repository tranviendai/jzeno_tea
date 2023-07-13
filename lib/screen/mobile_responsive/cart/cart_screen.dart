import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jzeno_tea/app/constants/app_constant.dart';
import 'package:jzeno_tea/screen/mobile_responsive/cart/bloc/cart_cubit.dart';
import 'package:jzeno_tea/app/model/cart_model.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {

  double setHeight(int lenght){
    double height = 0;
    for(int i =0 ;i<lenght;i++){
      height = 32.0 * lenght;
    }
    return height;
  }

  @override
  Widget build(BuildContext context) {
   double heightTopping = 0;
    return BlocBuilder<CartCubit, CartModel>(builder: (context, state) {
      return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back_ios),
            ),
            title: Text(AppText.cartText),
            actions: [
              state.products!.isNotEmpty
                  ? Container(
                      margin: EdgeInsets.only(right: 20),
                      alignment: Alignment.center,
                      child: RichText(
                        text: TextSpan(children: [
                          TextSpan(
                              text: "Total: ",
                              style: AppText.h2
                                  .copyWith(fontWeight: FontWeight.bold)),
                          TextSpan(
                              text:
                                  "\$${state.totalPrice.toStringAsPrecision(4)}",
                              style: AppText.h0)
                        ]),
                      ))
                  : Container()
            ],
          ),
          body: state.products!.isNotEmpty
              ? SizedBox(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: ListView.builder(
                    itemCount: state.products!.length,
                    itemBuilder: (context, index) {
                      var product = state.products![index];
                       heightTopping = setHeight(product.topping!.length);
                      return Container(
                        margin: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Theme.of(context).primaryColor),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Image.network(
                                  AppImage.path + product.image!,
                                  height: 100,
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        margin:
                                            EdgeInsets.symmetric(vertical: 5),
                                        child: Text(
                                          "${product.name!} (${product.size!})",
                                          style: AppText.h1,
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "\$${(product.price! * product.quantity!).toStringAsPrecision(3)}",
                                            style: AppText.h1
                                                .copyWith(color: Colors.red),
                                          ),
                                          Row(
                                            children: [
                                              product.quantity != 1
                                                  ? IconButton(
                                                      onPressed: () {
                                                        setState(() {
                                                          product.quantity =
                                                              product.quantity! -
                                                                  1;
                                                        });
                                                      },
                                                      icon: Icon(Icons.remove))
                                                  : IconButton(
                                                      onPressed: () {
                                                        context
                                                            .read<CartCubit>()
                                                            .removeToCart(
                                                                product);
                                                      },
                                                      icon: Icon(Icons
                                                          .delete_outlined)),
                                              Container(
                                                  padding: EdgeInsets.all(5),
                                                  child: Text(
                                                      "${product.quantity}")),
                                              IconButton(
                                                  onPressed: () {
                                                    setState(() {
                                                      product.quantity =
                                                          product.quantity! + 1;
                                                    });
                                                  },
                                                  icon: const Icon(Icons.add))
                                            ],
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            product.topping!.isNotEmpty
                                ? Container(
                                  margin: const EdgeInsets.all(4),
                                    height: heightTopping,
                                    child: ListView.builder(
                                      physics: const NeverScrollableScrollPhysics(),
                                      scrollDirection: Axis.vertical,
                                      itemCount: product.topping!.length,
                                      itemBuilder: (context, index) {
                                        var topping = product.topping![index];
                                        return Container(
                                          margin: const EdgeInsets.symmetric(horizontal: 20,vertical: 5),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                            Text(
                                              topping.name!,
                                              style: AppText.h2),
                                              Text(
                                              "\$${topping.price!}",
                                              style: AppText.h2)
                                          ]),
                                        );
                                      },
                                    ),
                                  )
                                : SizedBox(
                                    height: 40,
                                    child: Container(
                                        margin: const EdgeInsets.all(5),
                                        child: Text(
                                          AppText.notify02,
                                          style: AppText.h3,
                                          maxLines: 1,
                                        )),
                                  )
                          ],
                        ),
                      );
                    },
                  ))
              : Center(
                  child: Text(AppText.notify03),
                ));
    });
  }
}
