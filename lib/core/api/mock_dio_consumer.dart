import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:sirius_transfer_app/core/api/api_consumer.dart';

@Singleton(as: ApiConsumer)
class MockDioConsumer implements ApiConsumer {
  // In-memory storage
  final List<Map<String, dynamic>> _requests = [];

  MockDioConsumer() {
    _initializeDummyData();
  }

  void _initializeDummyData() {
    _requests.addAll([
      {
        'id': '1',
        'fromWallet': 'Neo',
        'toWallet': 'Whish',
        'amount': 500.0,
        'receiverName': 'John Doe',
        'receiverPhone': '+961 71 123 456',
        'note': 'Monthly subscription payment',
        'status': 'Completed',
        'createdAt': DateTime.now().subtract(const Duration(days: 2)).toIso8601String(),
      },
      {
        'id': '2',
        'fromWallet': 'Bo2',
        'toWallet': 'Whish',
        'amount': 250.50,
        'receiverName': 'Test User',
        'receiverPhone': '+961 76 987 654',
        'note': 'Birthday gift',
        'status': 'Pending',
        'createdAt': DateTime.now().subtract(const Duration(hours: 5)).toIso8601String(),
      },
      {
        'id': '3',
        'fromWallet': 'Whish',
        'toWallet': 'Neo',
        'amount': 1000.0,
        'receiverName': 'Test Test',
        'receiverPhone': '+961 70 555 888',
        'note': 'Freelance payment',
        'status': 'Completed',
        'createdAt': DateTime.now().subtract(const Duration(days: 7)).toIso8601String(),
      },
    ]);
  }

  Future<void> _simulateDelay() async {
    await Future.delayed(const Duration(milliseconds: 1500));
  }

  //Function to simulate error
  // void _simulateRandomError() {
  //   if (DateTime.now().millisecond % 10 == 0) {
  //     throw DioException(
  //       requestOptions: RequestOptions(path: ''),
  //       type: DioExceptionType.unknown,
  //       message: 'Simulated network error',
  //     );
  //   }
  // }

  @override
  Future get(String path, {Map<String, dynamic>? queryParameters, CancelToken? cancelToken}) async {
    await _simulateDelay();
    // _simulateRandomError();

    if (path.contains('transfers')) {
      return jsonEncode(_requests);
    }

    throw DioException(
      requestOptions: RequestOptions(path: path),
      type: DioExceptionType.badResponse,
      response: Response(
        requestOptions: RequestOptions(path: path),
        statusCode: 404,
        data: {'message': 'Endpoint not found'},
      ),
    );
  }

  @override
  Future post(String path, {Map<String, dynamic>? body, FormData? formData, CancelToken? cancelToken}) async {
    await _simulateDelay();
    //Simulate Random Error
    // _simulateRandomError();

    if (path.contains('transfers')) {
      final newRequest = {
        'id': DateTime.now().millisecondsSinceEpoch.toString(),
        ...?body,
        'status': 'Pending',
        'createdAt': DateTime.now().toIso8601String(),
      };

      _requests.insert(0, newRequest);
      return jsonEncode(newRequest);
    }

    throw DioException(
      requestOptions: RequestOptions(path: path),
      type: DioExceptionType.badResponse,
      response: Response(
        requestOptions: RequestOptions(path: path),
        statusCode: 404,
        data: {'message': 'Endpoint not found'},
      ),
    );
  }

  @override
  Future delete(String path, {Map<String, dynamic>? body, CancelToken? cancelToken}) async {
    await _simulateDelay();
    return jsonEncode({'success': true});
  }

  @override
  Future patch(String path, {Map<String, dynamic>? body, CancelToken? cancelToken}) async {
    await _simulateDelay();
    return jsonEncode({'success': true});
  }

  @override
  Future put(String path, {Map<String, dynamic>? body, CancelToken? cancelToken}) async {
    await _simulateDelay();
    return jsonEncode({'success': true});
  }
}
