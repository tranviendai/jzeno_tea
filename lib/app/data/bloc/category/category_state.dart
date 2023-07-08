import 'package:jzeno_tea/app/model/category_model.dart';

abstract class CategoryState {}

class CategoryLoading extends CategoryState {}

class CategorysLoaded extends CategoryState{
  final List<CategoryModel> categories;
  CategorysLoaded(this.categories);
}

class CategoryError extends CategoryState{
  final String? message;
  CategoryError(this.message);
}
