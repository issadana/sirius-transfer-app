import 'package:dio/dio.dart';

abstract class ApiConsumer {
  Future<dynamic> get(
    String path, {
    Map<String, dynamic>? queryParameters,
    CancelToken? cancelToken,
  });

  Future<dynamic> post(
    String path, {
    Map<String, dynamic>? body,
    FormData? formData,
    CancelToken? cancelToken,
  });

  Future<dynamic> put(
    String path, {
    Map<String, dynamic>? body,
    CancelToken? cancelToken,
  });

  Future<dynamic> delete(
    String path, {
    Map<String, dynamic>? body,
    CancelToken? cancelToken,
  });

  Future<dynamic> patch(
    String path, {
    Map<String, dynamic>? body,
    CancelToken? cancelToken,
  });
}