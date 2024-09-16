import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController with AppUtilsMixin {
  LoginController(this._repo);

  final LoginRepository _repo;
  TextEditingController phoneNumberTEC = TextEditingController();
  RxBool isLoading = false.obs;
  RxBool isEnableConfirmButton = false.obs;
  RxBool isValid = false.obs;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  /// validate phone number
  void onChangePhoneNumber({required String? value}) {
    if (value != null && value.length == 11) {
      isValid.value =
          AppRegex.checkValidField(value, AppRegex.phoneNumberRegex);
      isEnableConfirmButton(isValid.value);
      formKey.currentState!.validate();
    } else {
      isEnableConfirmButton(false);
    }
  }

  /// request login
  void onTapLogin() {
    isLoading(true);
    LoginRequestModel requestModel =
        LoginRequestModel(phoneNumber: phoneNumberTEC.text);
    _repo.login(requestModel: requestModel).then((LoginResponseModel response) {
      isLoading(false);
      update();
      responseHandler(
        statusCode: response.statusCode!,
        message: response.message!,
        onSuccess: () {
          Get.toNamed(
            AppRoutes.OTP,
            arguments: {
              'phoneNumber': phoneNumberTEC.text,
            },
          );
        },
      );
    });
  }
}
