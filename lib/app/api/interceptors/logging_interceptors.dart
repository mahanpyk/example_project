import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class LoggingInterceptor extends Interceptor {
  LoggingInterceptor(this._dio);

  final Dio _dio;
  String? _refreshToken;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (kDebugMode) {
      debugPrint(
        '''********************************
REQUEST: ${options.method} 
PATH: ${options.baseUrl + options.path} 
QP: ${options.queryParameters} 
DATA: ${options.data}
HEADER: ${options.headers}
********************************''',
        wrapWidth: 8192,
      );
    }
    return super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    if (kDebugMode) {
      debugPrint(
        '''********************************
RESPONSE: ${response.statusMessage}
PATH: ${response.requestOptions.path}
DATA: ${response.toString()}
STATUS: ${response.statusCode}
HEADER ${response.headers}
********************************''',
        wrapWidth: 8192,
      );
    }
    return super.onResponse(response, handler);
  }

  @override
  Future<void> onError(DioException err, ErrorInterceptorHandler handler) async {
    debugPrint(
      '''********************************
MESSAGE: ${err.message}
PATH: ${err.requestOptions.path}
DATA: ${err.toString()}
STATUS: ${err.response?.statusCode}
ERROR: ${err.error}
TYPE: ${err.type}
********************************''',
      wrapWidth: 8192,
    );

    if (err.response?.statusCode == 401) {
      final originalRequest = err.requestOptions;
      try {
        final newToken = await _refreshTokenRequest();
        if (newToken != null) {
          originalRequest.headers['Authorization'] = 'Bearer $newToken';
          final response = await _dio.fetch(originalRequest);
          return handler.resolve(response);
        } else {
          return handler.next(err);
        }
      } catch (e) {
        return handler.next(err);
      }
    }

    switch (err.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.badCertificate:
      case DioExceptionType.connectionError:
        throw DeadlineExceededException(err.requestOptions);
      case DioExceptionType.badResponse:
        switch (err.response?.statusCode) {
          case 400:
            throw BadRequestException(err.requestOptions);
          case 401:
            throw UnauthorizedException(err.requestOptions);
          case 403:
            throw ForbiddenException(err.requestOptions);
          case 404:
            throw NotFoundException(err.requestOptions);
          case 409:
            throw ConflictException(err.requestOptions);
          case 500:
            throw InternalServerErrorException(err.requestOptions);
          case 502:
            throw InternalServerErrorException(err.requestOptions);
        }
        break;
      case DioExceptionType.cancel:
      case DioExceptionType.unknown:
        throw NoInternetConnectionException(err.requestOptions);
    }

    return handler.next(err);
  }

  Future<String?> _refreshTokenRequest() async {
    try {
      final response = await _dio.post('YOUR_REFRESH_TOKEN_URL', data: {
        'refresh_token': _refreshToken,
      });

      if (response.statusCode == 200) {
        final newToken = response.data['access_token'];
        _refreshToken = response.data['refresh_token']; // به‌روزرسانی توکن رفرش
        return newToken;
      }
    } catch (e) {
      debugPrint('Error during token refresh: $e');
    }
    return null;
  }
}

class BadRequestException extends DioException {
  BadRequestException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return 'Invalid request';
  }
}

class InternalServerErrorException extends DioException {
  InternalServerErrorException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return 'Unknown error occurred, please try again later.';
  }
}

class ConflictException extends DioException {
  ConflictException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return 'Conflict occurred';
  }
}

class UnauthorizedException extends DioException {
  UnauthorizedException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return 'Access denied';
  }
}

class ForbiddenException extends DioException {
  ForbiddenException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return 'Forbidden';
  }
}

class NotFoundException extends DioException {
  NotFoundException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return 'The requested information could not be found';
  }
}

class NoInternetConnectionException extends DioException {
  NoInternetConnectionException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return 'No internet connection detected, please try again.';
  }
}

class DeadlineExceededException extends DioException {
  DeadlineExceededException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return 'The connection has timed out, please try again.';
  }
}
