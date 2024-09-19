import 'package:dio/dio.dart';

class RepositorySingleton {
  factory RepositorySingleton() => _instance;

  RepositorySingleton._internal();

  static final Dio _dio = Dio(
    BaseOptions(
      baseUrl: AppConstants.BASE_URL,
      // آدرس بیس URL پروژه شما
      receiveTimeout: const Duration(seconds: 15),
      sendTimeout: const Duration(seconds: 15),
      connectTimeout: const Duration(seconds: 15),
      receiveDataWhenStatusError: true,
      followRedirects: false,
      validateStatus: (status) {
        if (status != null) {
          return status <= 500;
        }
        return true;
      },
    ),
  )..interceptors.addAll([LoggingInterceptor()]);

  static final RepositorySingleton _instance = RepositorySingleton._internal();

  Future<ResponseModel> request({
    required String url,
    required String method,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? data,
    String urlParameters = '',
    Map<String, dynamic>? queryParameters,
    bool requiredToken = true,
  }) async {
    try {
      if (ConnectivityService.instance.hasConnection) {
        if (requiredToken) {
          String? token = await UserStoreService.to.getToken();
          headers = headers ?? {};
          headers.addAll({'Authorization': 'Bearer $token'});
        }

        final Response response = await _dio.request(
          url + urlParameters,
          data: data,
          queryParameters: queryParameters,
          options: Options(
            method: method,
            headers: headers,
          ),
        );

        if (response.statusCode == 200) {
          return ResponseModel(
            body: response.data,
            statusCode: response.statusCode,
            success: true,
            message: response.statusMessage,
          );
        } else {
          return ResponseModel(
            body: response.data,
            statusCode: response.statusCode,
            success: false,
            message: response.statusMessage,
          );
        }
      } else {
        return ResponseModel(
          body: 'No internet connection',
          statusCode: 500,
          success: false,
          message: 'No internet connection',
        );
      }
    } catch (e) {
      return ResponseModel(
        body: e.toString(),
        statusCode: 500,
        success: false,
        message: 'Request failed',
      );
    }
  }

  Dio get dio => _dio;
}
