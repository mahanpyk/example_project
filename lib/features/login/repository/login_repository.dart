import 'package:sentry_flutter/sentry_flutter.dart';

abstract class LoginRepository extends BaseRepository {
  Future<LoginResponseModel> login({required LoginRequestModel requestModel});
}

class LoginRepositoryImpl extends LoginRepository {
  @override
  Future<LoginResponseModel> login(
      {required LoginRequestModel requestModel}) async {
    final ResponseModel response = await request(
      requestData: RequestsParamsEnum.login,
      data: requestModel.toJson(),
      requiredToken: false,
    );
    LoginResponseModel result = LoginResponseModel();
    try {
      if (response.success) {
        result = loginResponseModelFromJson(response.body);
        result.statusCode = response.statusCode;
        return result;
      } else {
        await Sentry.captureException(
          response.body,
          stackTrace: response.message,
        );
        result.message = response.message;
        result.statusCode = response.statusCode;
        return result;
      }
    } catch (e) {
      result.message = e.toString();
      result.statusCode = 600;
      return result;
    }
  }
}
