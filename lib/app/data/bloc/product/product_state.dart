import 'package:jzeno_tea/app/model/product_model.dart';

abstract class ProductState {}

class ProductLoading extends ProductState {}

class ProductsLoaded extends ProductState{
  final List<ProductModel> products;
  ProductsLoaded(this.products);
}

class ProductAdded extends ProductState{
  final ProductModel product;
  ProductAdded(this.product);
}
class ProductUpdated extends ProductState{
  final ProductModel product;
  ProductUpdated(this.product);
}
class ProductDeleted extends ProductState{
  final ProductModel product;
  ProductDeleted(this.product);
}
class ProductError extends ProductState{
  final String? message;
  ProductError(this.message);
}
