import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jzeno_tea/app/constants/app_constant.dart';
import 'package:jzeno_tea/screen/mobile_responsive/cart/bloc/cart_cubit.dart';
import 'package:jzeno_tea/app/data/repository/api/api.dart';
import 'package:jzeno_tea/app/model/product_model.dart';
import 'package:jzeno_tea/app/model/topping_model.dart';

class AddCartScreen extends StatefulWidget {
  final ProductModel product;
  final List<ToppingModel> topping;
  const AddCartScreen(
      {super.key, required this.product, required this.topping});

  @override
  State<AddCartScreen> createState() => _AddCartScreenState();
}

enum SizeList { S, M, L }

class _AddCartScreenState extends State<AddCartScreen> {
  String path = "${API().baseUrl}/images/";
  SizeList? _size = SizeList.S;
  double totalPrice = 0;
  double totalTopping = 1;
  List<ToppingModel> tempTopping = [];
  List<ToppingModel> listTopping = [];

  @override
  void initState() {
    super.initState();
    totalPrice = AppPrice().productPrice(widget.product.price!, widget.product.discount!);
    tempTopping = widget.topping;
  }
  int count = 1;
  void itemCountPlus() {
    if (count > 11) count = 11;
    setState(() {
      count++;
    });
  }
  void itemCountMinus() {
    if (count < 2) count = 2;
    setState(() {
      count--;
    });
  }
  void onChangeSelect(dynamic value,double price) {
    setState(() {
      _size = value;
      totalPrice = price;
    });
  }
  @override
  void dispose() {
    super.dispose();
    totalPrice = 0;
    totalTopping = 0;
    for(int i =0; i<widget.topping.length;i++){
      tempTopping[i].isCheck = false;
    }
  }
  @override
  Widget build(BuildContext context) {
    double price = AppPrice()
        .productPrice(widget.product.price!, widget.product.discount!);
    double typeS = price;
    double typeM = price + (price * 0.2);
    double typeL = price + (price * 0.4);
    return Container(
        height: MediaQuery.of(context).size.height / 1.1,
        margin: const EdgeInsets.all(20),
        child: Stack(
          children: [
            Positioned(
                right: -10,
                top: -10,
                child: IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(
                      Icons.close,
                      size: 32,
                    ))),
            Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(children: [
                    Image.network(path + widget.product.image!, height: 100),
                    Container(
                        alignment: Alignment.topLeft,
                        width: MediaQuery.of(context).size.width / 1.95,
                        child: Text(widget.product.name!, style: AppText.h1))
                  ]),
                  AppText.textAlignLeft(
                      Text("Select Size:", style: AppText.h1)),
                  RadioListTile(
                      title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Size S', style: AppText.h2),
                            Text("\$${typeS.toStringAsPrecision(3)}",
                                style: AppText.h2)
                          ]),
                      value: SizeList.S,
                      groupValue: _size,
                      onChanged: (value) => onChangeSelect(value,typeS)),
                  RadioListTile(
                      title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Size M', style: AppText.h2),
                            Text("\$${typeM.toStringAsPrecision(3)}",
                                style: AppText.h2)
                          ]),
                      value: SizeList.M,
                      groupValue: _size,
                      onChanged:(value) => onChangeSelect(value,typeM)),
                  RadioListTile(
                      title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Size L', style: AppText.h2),
                            Text("\$${typeL.toStringAsPrecision(3)}",
                                style: AppText.h2)
                          ]),
                      value: SizeList.L,
                      groupValue: _size,
                      onChanged: (value) => onChangeSelect(value,typeL)),
                  Column(children: [
                    AppText.textAlignLeft(Text(
                        "Select Topping (Maximum: ${tempTopping.length}):",
                        style: AppText.h1)),
                    Container(
                        height: MediaQuery.of(context).size.height / 3.5,
                        padding: const EdgeInsets.all(10),
                        child: ListView.builder(
                            padding: EdgeInsets.zero,
                            shrinkWrap: true,
                            itemCount: tempTopping.length,
                            itemBuilder: (context, index) {
                              var topping = tempTopping[index];
                              return Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(children: [
                                      Checkbox(
                                          value: topping.isCheck,
                                          onChanged: (value) {
                                            setState(() {
                                              topping.isCheck = value;
                                              if(topping.isCheck!) {
                                                totalTopping += topping.price!;
                                                listTopping.add(topping);
                                              } 
                                              else {
                                                totalTopping -=topping.price!;
                                                listTopping.remove(topping);
                                              };
                                            });
                                          }),
                                      Container(
                                          margin:
                                              const EdgeInsets.only(left: 12),
                                          child: Text(
                                            topping.name!,
                                            style: AppText.h2,
                                          ))
                                    ]),
                                    Container(
                                      margin: const EdgeInsets.only(right: 8),
                                      child: Text("\$${topping.price!}",
                                          style: AppText.h2),
                                    )
                                  ]);
                            }))
                  ]),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                            flex: 1,
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  IconButton(
                                      onPressed: itemCountMinus,
                                      icon: Icon(Icons.remove)),
                                  Text("${count}"),
                                  IconButton(
                                      onPressed: itemCountPlus,
                                      icon: Icon(Icons.add))
                                ])),
                        Expanded(
                            flex: 2,
                            child: ElevatedButton(
                                child: Text("Add ${((totalPrice*count)+(totalTopping * count)).toStringAsPrecision(3)}"),
                                onPressed: () {

                                  Navigator.pop(context);
                                 context.read<CartCubit>().addToCart(ProductModel(
                                    id: widget.product.id,
                                    name: widget.product.name,
                                    price: _size!.index == 0 ? typeS : _size!.index == 1 ? typeM : typeL ,
                                    description: "",
                                    discount: widget.product.discount,
                                    image: widget.product.image,
                                    isPublic: true,
                                    postDate: widget.product.postDate,
                                    size: _size!.index == 0 ? "S" : _size!.index == 1 ? "M" : "L",
                                    quantity: count,
                                    topping: listTopping
                                  ));
                                }))
                      ])
                ]),
          ],
        ));
  }
}
