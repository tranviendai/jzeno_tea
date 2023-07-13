import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jzeno_tea/app/model/cart_model.dart';
import 'package:jzeno_tea/app/model/product_model.dart';

class CartCubit extends Cubit<CartModel> {
  CartCubit():super(CartModel(products: []));

  List<ProductModel> pro = [];

  List<ProductModel> getItemCart(){
    emit(CartModel(products: pro));
    return pro;
  }
  void addToCart(ProductModel product) {
    pro.add(product);
    emit(CartModel(products: pro));
  }

  void removeToCart(ProductModel product) {
    pro.remove(product);
    emit(CartModel(products: pro));
  }
}
