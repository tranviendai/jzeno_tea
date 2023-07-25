import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jzeno_tea/app/constants/app_constant.dart';
import 'package:jzeno_tea/app/data/bloc/auth/auth_cubit.dart';
import 'package:jzeno_tea/app/data/bloc/auth/auth_state.dart';
import 'package:jzeno_tea/app/data/bloc/category/category_cubit.dart';
import 'package:jzeno_tea/app/data/bloc/category/category_state.dart';
import 'package:jzeno_tea/app/data/bloc/product/product_cubit.dart';
import 'package:jzeno_tea/app/data/bloc/product/product_state.dart';
import 'package:jzeno_tea/app/model/cart_model.dart';
import 'package:jzeno_tea/app/model/category_model.dart';
import 'package:jzeno_tea/app/model/product_model.dart';
import 'package:jzeno_tea/app/model/user_model.dart';
import 'package:jzeno_tea/screen/mobile_responsive/cart/bloc/cart_cubit.dart';
import 'package:jzeno_tea/screen/widget/category_gird.dart';
import 'package:jzeno_tea/screen/widget/layout/authen/profile/profile_screen.dart';
import 'package:jzeno_tea/screen/widget/layout/product/product_gird.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<ProductModel> products = [];
  List<CategoryModel> categories = [];
  @override
  void initState() {
    context.read<AuthCubit>().getUsers();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    UserModel user = UserModel();
    return Scaffold(
        body: NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) {
              return [
                SliverAppBar(
                    automaticallyImplyLeading: false,
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
                        automaticallyImplyLeading: false,
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
                                padding: const EdgeInsets.all(15),
                                child: BlocBuilder<CartCubit, CartModel>(
                                    builder: (context, state) =>
                                        state.products!.isEmpty
                                            ? const Icon(
                                                Icons.shopping_cart_outlined)
                                            : const Icon(Icons.shopping_cart)),
                              ))
                        ]))
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
                child: BlocBuilder<AuthCubit,AuthState>(
                  builder: (context, state) {
                  if(state is AuthLoadedState){
                    user = state.user!;
                  }
                    return InkWell(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => ProfileScreen(user: user)));
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                  backgroundImage: NetworkImage(user.image!),
                                  radius: 20),
                              Container(
                                margin: const EdgeInsets.all(10),
                                child: Text("Hello ${user.fullName}",
                                    style: AppText.h1),
                              ),
                            ],
                          ),
                          const Icon(Icons.arrow_forward_ios)
                        ],
                      ),
                    );
                  }
                ),
              ),
              Container(
                margin: const EdgeInsets.all(15),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(5)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 80,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Theme.of(context).primaryColor),
                      child: BlocBuilder<CategoryCubit, CategoryState>(
                        builder: (context, state) {
                          if (state is CategoryLoaded) {
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
                  return LayoutGirdProduct(products: products);
                }),
              )
            ]))));
  }
}
