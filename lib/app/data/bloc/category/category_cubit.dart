import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jzeno_tea/app/data/bloc/category/category_state.dart';
import 'package:jzeno_tea/app/data/repository/repository.dart';
import 'package:jzeno_tea/app/model/category_model.dart';

class CategoryCubit extends Cubit<CategoryState>{
  CategoryCubit():super(CategoryLoading()){
    fetchCategorys();
  }
  
   APIRepository repo = APIRepository();
  void fetchCategorys() async {
    try {
      List<CategoryModel> categories = await repo.fetchListCategory();
      emit(CategorysLoaded(categories));
    } catch (ex) {
      emit(CategoryError(ex.toString()));
    }
  }
}