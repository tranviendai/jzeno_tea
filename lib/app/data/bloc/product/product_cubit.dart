import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jzeno_tea/app/data/bloc/product/product_state.dart';
import 'package:jzeno_tea/app/data/repository/repository.dart';
import 'package:jzeno_tea/app/model/product_model.dart';

class ProductCubit extends Cubit<ProductState>{
  ProductCubit():super(ProductLoading()){
    fetchProducts();
  }
  
  static List<ProductModel> products = [];
  static ProductModel product = ProductModel();
   APIRepository repo = APIRepository();
  void fetchProducts() async {
    try {
      products = await repo.fetchListProduct();
      emit(ProductsLoaded(products));
    } catch (ex) {
      emit(ProductError(ex.toString()));
    }
  }
 void addProduct(ProductModel item) async {
    try {
      ProductModel product = await repo.addProduct(item);
      emit(ProductAdded(product));
    } catch (ex) {
      emit(ProductError(ex.toString()));
    }
  }
  void updateProduct(int id,ProductModel item) async {
    try {
      product = await repo.updateProduct(id,item);
      emit(ProductUpdated(product));
    } catch (ex) {
      emit(ProductError(ex.toString()));
    }
  }

  void removeProduct(int id) async {
    try {
      product = await repo.removeProduct(id);
      emit(ProductDeleted(product));
    } catch (ex) {
      emit(ProductError(ex.toString()));
    }
  }
  
}