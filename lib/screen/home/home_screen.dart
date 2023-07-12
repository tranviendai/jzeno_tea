import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jzeno_tea/app/constants/app_constant.dart';
import 'package:jzeno_tea/app/data/bloc/category/category_cubit.dart';
import 'package:jzeno_tea/app/data/bloc/category/category_state.dart';
import 'package:jzeno_tea/app/data/bloc/product/product_cubit.dart';
import 'package:jzeno_tea/app/data/bloc/product/product_state.dart';
import 'package:jzeno_tea/app/model/cart_model.dart';
import 'package:jzeno_tea/app/model/category_model.dart';
import 'package:jzeno_tea/app/model/product_model.dart';
import 'package:jzeno_tea/screen/cart/bloc/cart_cubit.dart';
import 'package:jzeno_tea/screen/widget/category_gird.dart';
import 'package:jzeno_tea/screen/widget/product_gird.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<ProductModel> products = [];
  List<CategoryModel> categories = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) {
              return [
                SliverAppBar(
                  expandedHeight: 240,
                  flexibleSpace: FlexibleSpaceBar(
                    background: Image.asset(
                      AppImage.bgMilkTea,
                      fit: BoxFit.cover,
                    ),
                  ),
                  floating: true,
                  // snap: true,
                  pinned: true,
                  bottom: AppBar(
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                    title: Text(AppText.titleApp.toUpperCase(),
                        style: AppText.h0.copyWith(color: Colors.white)),
                    actions: [
                      InkWell(
                        borderRadius: BorderRadius.circular(25),
                        onTap: () {
                          Navigator.pushNamed(context, "Cart");
                        },
                        child: Container(
                          padding: EdgeInsets.all(15),
                          child: BlocBuilder<CartCubit, CartModel>(
                              builder: (context, state) =>
                                  state.products!.isEmpty
                                      ? Icon(Icons.shopping_cart_outlined)
                                      : Icon(Icons.shopping_cart)),
                        ),
                      )
                    ],
                  ),
                ),
              ];
            },
            body: SingleChildScrollView(
                child: Column(children: [
              Container(
                margin: const EdgeInsets.all(15),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(5)),
                child: InkWell(
                  onTap: () {},
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                              backgroundImage: AssetImage(AppImage.logo),
                              radius: 20),
                          Container(
                            margin: const EdgeInsets.all(10),
                            child: Text("Hello ${AppText.welcomeHeader}",
                                style: AppText.h1),
                          ),
                        ],
                      ),
                      const Icon(Icons.arrow_forward_ios)
                    ],
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.all(15),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(5)),
                child: Row(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width - 50,
                      height: 80,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Theme.of(context).primaryColor),
                      child: BlocBuilder<CategoryCubit, CategoryState>(
                        builder: (context, state) {
                          if (state is CategorysLoaded) {
                            categories = state.categories;
                          }
                          return girdCategories(categories.reversed.toList());
                        },
                      ),
                    )
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 10),
                child: BlocBuilder<ProductCubit, ProductState>(
                    builder: (context, state) {
                  if (state is ProductsLoaded) {
                    products = state.products;
                  }
                  return girdProduct(products);
                }),
              )
            ]))));
  }
}
