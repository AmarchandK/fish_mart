import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

import '../config/app_config.dart';
import '../error/exceptions.dart';

class ApiClient {
  final Dio _dio;
  final Logger _logger;

  ApiClient(this._dio) : _logger = Logger() {
    _dio.options = BaseOptions(
      baseUrl: AppConfig.baseUrl,
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      sendTimeout: const Duration(seconds: 30),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    );

    // Add interceptors
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          _logger.d('REQUEST[${options.method}] => PATH: ${options.path}');
          _logger.d('REQUEST DATA: ${options.data}');
          handler.next(options);
        },
        onResponse: (response, handler) {
          _logger.d(
              'RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.path}');
          _logger.d('RESPONSE DATA: ${response.data}');
          handler.next(response);
        },
        onError: (error, handler) {
          _logger.e(
              'ERROR[${error.response?.statusCode}] => PATH: ${error.requestOptions.path}');
          _logger.e('ERROR MESSAGE: ${error.message}');
          handler.next(error);
        },
      ),
    );
  }

  Future<Map<String, dynamic>> get(
    String path, {
    Map<String, dynamic>? queryParameters,
    Map<String, String>? headers,
  }) async {
    try {
      final response = await _dio.get<dynamic>(
        path,
        queryParameters: queryParameters,
        options: Options(headers: headers),
      );
      return _handleResponse(response);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<Map<String, dynamic>> post(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Map<String, String>? headers,
  }) async {
    try {
      final response = await _dio.post<dynamic>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: Options(headers: headers),
      );
      return _handleResponse(response);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<Map<String, dynamic>> put(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Map<String, String>? headers,
  }) async {
    try {
      final response = await _dio.put<dynamic>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: Options(headers: headers),
      );
      return _handleResponse(response);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<Map<String, dynamic>> delete(
    String path, {
    Map<String, dynamic>? queryParameters,
    Map<String, String>? headers,
  }) async {
    try {
      final response = await _dio.delete<dynamic>(
        path,
        queryParameters: queryParameters,
        options: Options(headers: headers),
      );
      return _handleResponse(response);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Map<String, dynamic> _handleResponse(Response<dynamic> response) {
    if (response.statusCode! >= 200 && response.statusCode! < 300) {
      if (response.data is Map<String, dynamic>) {
        return response.data as Map<String, dynamic>;
      } else {
        // Handle cases where API returns different structure
        return {'success': true, 'data': response.data};
      }
    } else {
      throw ServerException(
        message: 'Server error: ${response.statusCode}',
        statusCode: response.statusCode,
      );
    }
  }

  Exception _handleError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return const NetworkException(message: 'Connection timeout');

      case DioExceptionType.badResponse:
        final data = error.response?.data;
        final message =
            data is Map<String, dynamic> && data.containsKey('message')
                ? data['message']?.toString() ?? 'Server error'
                : 'Server error';
        return ServerException(
          message: message,
          statusCode: error.response?.statusCode,
        );

      case DioExceptionType.cancel:
        return const NetworkException(message: 'Request cancelled');

      case DioExceptionType.connectionError:
        return const NetworkException(message: 'No internet connection');

      default:
        return NetworkException(message: error.message ?? 'Unknown error');
    }
  }
}
