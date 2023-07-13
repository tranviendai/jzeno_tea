import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class API{
  final Dio _dio = Dio();
  //flutter run -d chrome --web-port=4000
  // String baseUrl = "http://10.0.2.2:5172";
   String baseUrl = "http://127.0.0.1:5172";


  API(){
    _dio.options.baseUrl = "$baseUrl/api";
    // _dio.interceptors.add(PrettyDioLogger());
  }

  Dio get sendRequest => _dio;
}