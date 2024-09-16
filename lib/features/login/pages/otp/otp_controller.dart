import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OTPController extends GetxController with AppUtilsMixin {
  OTPController(this._repo);

  final OTPRepository _repo;
  late final String phoneNumber;
  TextEditingController verifyCodeTEC = TextEditingController();
  RxBool isLoadingConfirmCode = false.obs;
  RxBool isLoadingResendCode = false.obs;
  RxBool isEnableVerifyButton = false.obs;
  RxBool resendOTPEnable = false.obs;
  RxString timerText = '2:00'.obs;
  int counter = 120;
  Timer? _timer;

  @override
  void onInit() {
    super.onInit();
    var data = Get.arguments;
    if (data != null) {
      phoneNumber = data['phoneNumber'];
    } else {
      phoneNumber = '';
    }
    countDownTimer();
    initSmsAutoFill();
  }

  // todo: pending for backend
  /// for autofill verify code
  void initSmsAutoFill() async {
    try {
      await SmsAutoFill().unregisterListener();
    } catch (error) {
      debugPrint('*****************');
      debugPrint('Error unregisterListener: $error');
      debugPrint('-----------------');
    }
    try {
      await SmsAutoFill().listenForCode();
      SmsAutoFill().code.listen((event) {
        event.trim();
        List<String> sms = [];
        for (int i = 0; i < event.length; i++) {
          String t = event.substring(i, i + 1);
          sms.add(t);
        }
        String code = '';
        for (int i = 0; i < sms.length; i++) {
          code = code + sms[i];
        }
        verifyCodeTEC.text = code.trim();
        if (verifyCodeTEC.text.length == 5) {
          onTapVerifyCodeButton();
        }
      });
    } catch (error) {
      debugPrint('*****************');
      debugPrint('Error listenForCode: $error');
      debugPrint('-----------------');
    }
  }

  /// back to login page for edit phone number
  void onTapEditButton() => Get.back();

  /// calculate counter for resend OTP Code
  void countDownTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (counter == 0) {
        _timer!.cancel();
        resendOTPEnable(true);
      } else {
        counter -= 1;
        int minutes = (counter / 60).truncate();
        int seconds = (counter % 60).round();
        timerText(
            '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}');
      }
    });
  }

  /// enable verify button when fill text field
  void onChangeOTPCode({required String value}) {
    if (value.length == 5) {
      isEnableVerifyButton(true);
    } else {
      isEnableVerifyButton(false);
    }
  }

  /// resend verify Code request
  void onTapResendOTPButton() {
    if (resendOTPEnable.value) {
      counter = 120;
      timerText('02:00');
      resendOTPEnable(false);
      countDownTimer();
      resendOTPRequest();
    }
  }

  /// request resend verify code
  void resendOTPRequest() {
    isLoadingResendCode(true);
    LoginRequestModel requestModel =
        LoginRequestModel(phoneNumber: phoneNumber);
    _repo
        .resendVerifyCode(requestModel: requestModel)
        .then((LoginResponseModel response) {
      isLoadingResendCode(false);
      responseHandler(
        statusCode: response.statusCode!,
        message: response.message!,
        onSuccess: () {},
      );
    });
  }

  /// request confirm verify code
  void onTapVerifyCodeButton() {
    isLoadingConfirmCode(true);
    OTPRequestModel requestModel = OTPRequestModel(
      phoneNumber: phoneNumber,
      password: verifyCodeTEC.text,
    );
    _repo
        .confirmVerifyCode(requestModel: requestModel)
        .then((OTPResponseModel response) {
      isLoadingConfirmCode(false);
      responseHandler(
        statusCode: response.statusCode!,
        message: response.message!,
        onSuccess: () {
          UserStoreService.to.saveToken(response.data!.access!);
          UserStoreService.to.saveRefreshToken(response.data!.refresh!);
          userProfileRequest();
        },
      );
    });
  }

  /// request user profile
  void userProfileRequest() {
    _repo.userProfile().then((ProfileResponseModel response) {
      isLoadingConfirmCode(false);
      responseHandler(
        statusCode: response.statusCode!,
        message: response.message!,
        onSuccess: () {
          if (response.data!.user!.firstName == '') {
            Get.offAllNamed(AppRoutes.REGISTRATION);
          } else if (response.data!.goal == null) {
            Get.offAllNamed(
              AppRoutes.REGISTRATION,
              arguments: {'page': 1},
            );
          } else {
            Get.offAllNamed(AppRoutes.HOME);
          }
        },
      );
    });
  }

  @override
  void onClose() {
    SmsAutoFill().unregisterListener();
    super.onClose();
  }
}
