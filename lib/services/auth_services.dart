import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:gereja_flutter/utils/base_url.dart';
import 'package:gereja_flutter/utils/dio_interceptor.dart';
import 'package:loader_overlay/loader_overlay.dart';

class AuthServices {
  late final Dio _dio;

  AuthServices() {
    _dio = Dio();
    _dio.interceptors.add(DioInterceptor());
  }

  final String _baseUrl = BaseUrl().baseUrl;

  Future<dynamic> login(Map<String, dynamic> body, BuildContext context) async {
    context.loaderOverlay.show();
    try {
      final response = await _dio.post("$_baseUrl/login", data: body);
      context.loaderOverlay.hide();
      return response;
    } on DioException catch (e) {
      context.loaderOverlay.hide();
      return e;
    }
  }

  Future<dynamic> register(
      Map<String, dynamic> body, BuildContext context) async {
    context.loaderOverlay.show();
    try {
      final response = await _dio.post("$_baseUrl/register", data: body);
      context.loaderOverlay.hide();
      return response;
    } on DioException catch (e) {
      context.loaderOverlay.hide();

      dynamic statusCode = e!.response!.statusCode;

      if (statusCode == 401) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('${e.response!.data['data']}'),
          duration: Duration(seconds: 3),
          backgroundColor: Colors.red,
        ));
      }
      return e;
    }
  }

  Future<dynamic> logout(BuildContext context) async {
    context.loaderOverlay.show();
    try {
      final response = await _dio.post("$_baseUrl/logout");
      context.loaderOverlay.hide();
      return response;
    } on DioException catch (e) {
      print(e.message);
      context.loaderOverlay.hide();
      return e;
    }
  }
}
