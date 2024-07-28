import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:gereja_flutter/utils/base_url.dart';
import 'package:gereja_flutter/utils/dio_interceptor.dart';

class SettingServices {
  late final Dio _dio;

  SettingServices() {
    _dio = Dio();
    _dio.interceptors.add(DioInterceptor());
  }

  final String _baseUrl = BaseUrl().baseUrl;

  Future<dynamic> get(String param) async {
    try {
      final response = await _dio.get("$_baseUrl/setting/$param");
      return response;
    } on DioException catch (e) {
      debugPrint(e.response.toString());
      return e;
    }
  }
}
