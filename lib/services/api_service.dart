import 'package:dio/dio.dart';

class ApiService {
  late final Dio _dio;

  ApiService(){
    _dio = Dio(
      BaseOptions(
        baseUrl:  'https://fakestoreapi.com/',
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout:  const Duration(seconds:  10),
        headers: {
          'Content-Type' : 'application/json',
          'Accept' : 'application/json'
        }
      ),
    );
    _dio.interceptors.add(
      LogInterceptor(
        requestBody: true,
        responseBody: true,
        error: true,
        logPrint: (log) => print('[DIO] $log'),
      ),
    );
  }
  Dio get client => _dio;

  Future<Response> getProducts() async{
    return await _dio.get('products');
  }
}