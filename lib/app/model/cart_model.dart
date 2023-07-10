import 'package:jzeno_tea/app/model/product_model.dart';
import 'package:jzeno_tea/app/model/topping_model.dart';

class CartModel{
  List<ProductModel>? products;
  List<ToppingModel>? toppings;
  CartModel({this.products, this.toppings});
}