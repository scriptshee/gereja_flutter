import 'package:dio/dio.dart';
import 'package:gereja_flutter/utils/base_url.dart';
import 'package:gereja_flutter/utils/dio_interceptor.dart';

class EvenServices {
  late final Dio _dio;

  EvenServices() {
    _dio = Dio();
    _dio.interceptors.add(DioInterceptor());
  }

  final String _baseUrl = BaseUrl().baseUrl;

  Future<dynamic> get() async {
    try {
      final response = await _dio.get("$_baseUrl/event");
      return response;
    } on DioException catch (e) {
      return e;
    }
  }
}
