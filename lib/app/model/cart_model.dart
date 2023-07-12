import 'package:jzeno_tea/app/model/product_model.dart';

class CartModel{
  List<ProductModel>? products;
  CartModel({this.products});

  double get totalPrice => products!.fold(0, (total, current) => total + current.price! * current.quantity!);
}