import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:gereja_flutter/utils/base_url.dart';
import 'package:gereja_flutter/utils/dio_interceptor.dart';
import 'package:loader_overlay/loader_overlay.dart';

class NewsServices {
  late final Dio _dio;

  NewsServices() {
    _dio = Dio();
    _dio.interceptors.add(DioInterceptor());
  }

  final String _baseUrl = BaseUrl().baseUrl;

  Future<dynamic> get(BuildContext context) async {
    context.loaderOverlay.show();
    try {
      final response = await _dio.get("$_baseUrl/news");
      context.loaderOverlay.hide();
      return response;
    } on DioException catch (e) {
      context.loaderOverlay.hide();
      return e;
    }
  }
}
