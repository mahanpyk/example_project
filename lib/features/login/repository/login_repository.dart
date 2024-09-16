abstract class LoginRepository {
  Future<LoginResponseModel> login({required LoginRequestModel requestModel});
}

class LoginRepositoryImpl extends LoginRepository {
  LoginRepositoryImpl(this._repositorySingleton);

  final RepositorySingleton _repositorySingleton;

  @override
  Future<LoginResponseModel> login({required LoginRequestModel requestModel}) async {
    final ResponseModel response = await _repositorySingleton.request(
      url: 'login',
      method: 'POST',
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
