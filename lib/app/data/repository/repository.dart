import 'package:dio/dio.dart';
import 'package:jzeno_tea/app/model/category_model.dart';
import 'package:jzeno_tea/app/model/product_model.dart';
import 'package:jzeno_tea/app/data/repository/api/api.dart';

class APIRepository {
  API api = API();
  var header = {
     "Access-Control-Allow-Origin": "*",
            'Content-Type': 'application/json',
            'Accept': '*/*'
  };


  Future<List<ProductModel>> fetchListProduct() async {
    try {
      Response res = await api.sendRequest.get('/Products',
          options: Options(headers: header));
      List<dynamic> productMaps = res.data;
      return productMaps.map((e) => ProductModel.fromJson(e)).toList();
    } catch (ex) {
      rethrow;
    }
  }

  Future<ProductModel> addProduct(ProductModel product) async {
    try {
      Response res = await api.sendRequest.post('/Products',
          data: product.toJson(),
          options: Options(headers: header));
      return res.data;
    } catch (ex) {
      rethrow;
    }
  }

  Future<ProductModel> getDetailProduct(String id) async {
     try {
         Response res = await api.sendRequest.get('/Products/$id',
          options: Options(headers: header));
          var data = res.data;
      return ProductModel.fromJson(data);
    } catch (ex) {
      rethrow;
    }
  }

  Future<ProductModel> removeProduct(String id) async{
     try {
      Response res = await api.sendRequest.delete('/Products/$id',
          options: Options(headers: header));
      return res.data;
    } catch (ex) {
      rethrow;
    }
  }

    Future<List<CategoryModel>> fetchListCategory() async {
    try {
      Response res = await api.sendRequest.get('/Categories',
          options: Options(headers: header));
      List<dynamic> categoryMaps = res.data;
      return categoryMaps.map((e) => CategoryModel.fromJson(e)).toList();
    } catch (ex) {
      rethrow;
    }
  }


}
