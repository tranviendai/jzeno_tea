import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jzeno_tea/app/data/bloc/product/product_state.dart';
import 'package:jzeno_tea/app/data/repository/repository.dart';
import 'package:jzeno_tea/app/model/product_model.dart';

class ProductCubit extends Cubit<ProductState>{
  ProductCubit():super(ProductLoading()){
    fetchProducts();
  }
  
   APIRepository repo = APIRepository();
  void fetchProducts() async {
    try {
      List<ProductModel> products = await repo.fetchListProduct();
      emit(ProductsLoaded(products));
    } catch (ex) {
      emit(ProductError(ex.toString()));
    }
  }
}