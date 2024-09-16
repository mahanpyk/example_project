import 'package:dio/dio.dart';

class BaseRepository with AppUtilsMixin {
  static Dio dio = Dio(
    BaseOptions(
      baseUrl: AppConstants.BASE_URL,
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

  Future<ResponseModel> request({
    required String url,
    required String? method,
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
          headers?.addAll({'Authorization': 'Bearer $token'});
        }
        final Response response = await dio.request(
          url + urlParameters,
          data: data,
          queryParameters: queryParameters,
          options: Options(
            method: method,
            headers: headers,
          ),
        );
        if (response.statusCode == 200) {
          ResponseModel responseModel = ResponseModel(
            body: response.data,
            statusCode: 200,
            success: true,
            message: response.statusMessage,
          );
          return responseModel;
        } else if (response.statusCode == 401 || response.statusCode == 403) {
          if (await renewToken()) {
            return request(
              url: url,
              method: method,
              data: data,
              queryParameters: queryParameters,
              urlParameters: urlParameters,
              requiredToken: requiredToken,
            );
          } else {
            bool isOpenDialog = get_package.Get.isDialogOpen ?? false;
            if (!isOpenDialog) {
              AppDialog dialog = AppDialog(
                title: 'مشکلی پیش آمده',
                subTitle:
                    'مدت زمان حضور در برنامه به پایان رسیده است.\nلطفا جهت استفاده از برنامه، دوباره وارد شوید',
                mainTaskTitle: 'ورود به برنامه',
                mainTask: () => logoutFromApp(),
              );
              dialog.showAppDialog();
            }
            return ResponseModel(
              body: 'Exit',
              statusCode: 401,
              success: false,
              message: 'Log Out',
            );
          }
        } else {
          ResponseModel responseModel = ResponseModel(
            body: response.data,
            statusCode: response.statusCode,
            success: false,
            message: response.statusMessage,
          );
          return responseModel;
        }
      } else {
        AppDialog dialog = AppDialog(
          title: 'خطا در اتصال به اینترنت',
          subTitle: 'اتصال اینترنت خود را بررسی نمایید',
          mainTaskTitle: 'تلاش مجدد',
          mainTask: () {
            request(
              url: url,
              method: method,
              data: data,
              queryParameters: queryParameters,
              urlParameters: urlParameters,
              requiredToken: requiredToken,
            );
          },
          icon: AppIcons.icNoConnection,
        );
        dialog.showAppDialog();
        return ResponseModel(
          body: 'No internet connection',
          statusCode: 500,
          success: false,
          message: 'No internet connection',
        );
      }
    } on DioException catch (e, s) {
      return ResponseModel(
        body: e,
        statusCode: e.response?.statusCode ?? 500,
        success: false,
        message: s.toString(),
      );
    } catch (e, s) {
      return ResponseModel(
        body: e,
        statusCode: 600,
        success: false,
        message: s.toString(),
      );
    }
  }

  Future<bool> renewToken() async {
    String? refreshToken = await UserStoreService.to.getRefreshToken();
    bool result = false;
    if (refreshToken == null) {
      return false;
    }
    await dio.post(AppURLs.authTokenRefresh,
        options: Options(headers: {
          'Content-type': 'application/json',
          'Accept': 'application/json',
        }),
        data: {'refresh': refreshToken}).then((response) async {
      if (response.statusCode == 200) {
        RenewTokenModel renewToken = RenewTokenModel();
        renewToken = renewTokenFromJson(response.data);
        await UserStoreService.to.saveToken(renewToken.data!.access!);
        result = true;
      } else {
        result = false;
      }
    }).onError((error, stackTrace) {
      debugPrint('*****************');
      debugPrint(error.toString());
      debugPrint('-----------------');
    });
    return result;
  }
}
