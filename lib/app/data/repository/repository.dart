import 'package:dio/dio.dart';
import 'package:jzeno_tea/app/data/bloc/auth/auth_cubit.dart';
import 'package:jzeno_tea/app/model/category_model.dart';
import 'package:jzeno_tea/app/model/product_model.dart';
import 'package:jzeno_tea/app/data/repository/api/api.dart';
import 'package:jzeno_tea/app/model/topping_model.dart';
import 'package:jzeno_tea/app/model/user_model.dart';

class APIRepository {
  API api = API();
  var header = {
    "Access-Control-Allow-Origin": "*",
    'Content-Type': 'application/json',
    'Accept': '*/*',
  };

  Future<List<ProductModel>> fetchListProduct() async {
    try {
      Response res = await api.sendRequest
          .get('/Products', options: Options(headers: header));
      List<dynamic> productMaps = res.data;
      return productMaps.map((e) => ProductModel.fromListJson(e)).toList();
    } catch (ex) {
      rethrow;
    }
  }

  Future<String> login(String username, String password) async {
    try {
      final body = {'username': username, 'passwordHash': password};
      Response res = await api.sendRequest
          .post('/Auth/login', options: Options(headers: header), data: body);
      if (res.statusCode == 200) {
        final tokenData = res.data;
        AuthCubit.token = tokenData;
        return tokenData;
      } else {
        return "login error";
      }
    } catch (ex) {
      rethrow;
    }
  }

  Future<UserModel> getUser() async {
    try {
      Response res = await api.sendRequest.get('/Auth/current',
          options: Options(headers: {
            "Access-Control-Allow-Origin": "*",
            'Content-Type': 'application/json',
            'Accept': '*/*',
            'Authorization': 'Bearer ${AuthCubit.token}'
          }));
        return UserModel.fromJson(res.data);
    } catch (ex) {
      rethrow;
    }
  }

  Future<ProductModel> addProduct(ProductModel product) async {
    try {
      Response res = await api.sendRequest.post('/Products',
          data: product.toJson(), options: Options(headers: header));
      return res.data;
    } catch (ex) {
      rethrow;
    }
  }

  Future<ProductModel> updateProduct(int id, ProductModel product) async {
    try {
      Response res = await api.sendRequest.put('/Products/$id',
          data: product.toJson(), options: Options(headers: header));
      return res.data;
    } catch (ex) {
      rethrow;
    }
  }

  Future<ProductModel> removeProduct(int id) async {
    try {
      Response res = await api.sendRequest
          .delete('/Products/$id', options: Options(headers: header));
      return res.data;
    } catch (ex) {
      rethrow;
    }
  }

  Future<List<CategoryModel>> fetchListCategory() async {
    try {
      Response res = await api.sendRequest
          .get('/categories', options: Options(headers: header));
      List<dynamic> categoryMaps = res.data;
      return categoryMaps.map((e) => CategoryModel.fromJson(e)).toList();
    } catch (ex) {
      rethrow;
    }
  }

  Future<List<ToppingModel>> fetchListTopping() async {
    try {
      Response res = await api.sendRequest
          .get('/toppings', options: Options(headers: header));
      List<dynamic> toppingMaps = res.data;
      return toppingMaps.map((e) => ToppingModel.fromJson(e)).toList();
    } catch (ex) {
      rethrow;
    }
  }
}
