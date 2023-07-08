import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jzeno_tea/app/data/bloc/product/product_cubit.dart';
import 'package:jzeno_tea/app/data/bloc/product/product_state.dart';
import 'package:jzeno_tea/app/model/product_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<ProductModel>? products;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      extendBodyBehindAppBar: true,
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: BlocBuilder<ProductCubit, ProductState>(
            builder: (context, state) {
              if (state is ProductsLoaded) {
                products = state.products;
              }
              return ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: products!.length,
                itemBuilder: (context, index) {
                  var product = products![index];
                  return Container(
                    child: Text(product.name!),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
