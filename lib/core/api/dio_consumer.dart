import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:emtelek/core/api/api_consumer.dart';
import 'package:emtelek/core/api/api_interceptors.dart';
import 'package:emtelek/core/api/end_points.dart';
import 'package:emtelek/core/errors/error_model.dart';
import 'package:emtelek/core/errors/exceptions.dart';

class DioConsumer extends ApiConsumer {
  final Dio dio;
  String basicAuth =
      'Basic ${base64Encode(utf8.encode('${ApiKey.emtelekAuthUsername}:${ApiKey.emtelekAuthPass}'))}';

  DioConsumer({required this.dio}) {
    dio.options.baseUrl = EndPoints.baseUrl;
    dio.options.headers = {
      "Authorization": basicAuth,
      "Content-Type": "application/json",
    };
    // dio.interceptors.add(ApiInterceptors());
    dio.interceptors.add(LogInterceptor(
      request: true,
      requestBody: true,
      requestHeader: true,
      responseBody: true,
      responseHeader: true,
      error: true,
    ));
  }
  @override
  Future delete(
    String path, {
    data,
    Map<String, dynamic>? queryParameters,
    bool isFormData = false,
  }) async {
    try {
      final response = await dio.delete(
        path,
        data: isFormData ? FormData.fromMap(data) : data,
        queryParameters: queryParameters,
      );
      if (response.data is Map<String, dynamic> &&
          response.data["status"] == "failed") {
        throw ServerException(
          errorModel: ErrorModel.fromJson(response.data),
        );
      }
      return response.data;
    } on DioException catch (e) {
      handleDioExceptions(e);
    }
  }

  @override
  Future get(String path, {data, Map<String, dynamic>? queryParameters}) async {
    try {
      final response = await dio.get(
        path,
        data: data,
        queryParameters: queryParameters,
      );
      if (response.data is Map<String, dynamic> &&
          response.data["status"] == "failed") {
        throw ServerException(
          errorModel: ErrorModel.fromJson(response.data),
        );
      }
      return response.data;
    } on DioException catch (e) {
      handleDioExceptions(e);
    }
  }

  @override
  Future patch(
    String path, {
    data,
    Map<String, dynamic>? queryParameters,
    bool isFormData = false,
  }) async {
    try {
      final response = await dio.patch(
        path,
        data: isFormData ? FormData.fromMap(data) : data,
        queryParameters: queryParameters,
      );
      if (response.data is Map<String, dynamic> &&
          response.data["status"] == "failed") {
        throw ServerException(
          errorModel: ErrorModel.fromJson(response.data),
        );
      }
      return response.data;
    } on DioException catch (e) {
      handleDioExceptions(e);
    }
  }

  @override
  Future post(
    String path, {
    data,
    Map<String, dynamic>? queryParameters,
    bool isFormData = false,
  }) async {
    try {
      final response = await dio.post(
        path,
        data: isFormData ? FormData.fromMap(data) : data,
        queryParameters: queryParameters,
      );
      if (response.data is Map<String, dynamic> &&
          response.data["status"] == "failed") {
        throw ServerException(
          errorModel: ErrorModel.fromJson(response.data),
        );
      }
      return response.data;
    } on DioException catch (e) {
      handleDioExceptions(e);
    }
  }
}
