import 'package:dio/dio.dart';
import 'package:gereja_flutter/utils/base_url.dart';
import 'package:gereja_flutter/utils/dio_interceptor.dart';

class NotificationServices {
  late final Dio _dio;

  NotificationServices() {
    _dio = Dio();
    _dio.interceptors.add(DioInterceptor());
  }

  final String _baseUrl = BaseUrl().baseUrl;

  Future<dynamic> get() async {
    try {
      final response = await _dio.get("$_baseUrl/notification");
      return response;
    } on DioException catch (e) {
      return e;
    }
  }
}
