import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class OTPPage extends BaseView<OTPController> {
  const OTPPage({Key? key}) : super(key: key);

  @override
  Widget body() {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(children: [
            Image.asset(
              AppImages.imgLogin,
              width: Get.width,
              height: 375,
              fit: BoxFit.fill,
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'otp_title'.tr,
                      style: Get.textTheme.headline5,
                    ),
                    const SizedBox(height: 24),
                    RichText(
                      text: TextSpan(style: Get.textTheme.subtitle1, children: [
                        TextSpan(text: 'otp_description_part1'.tr),
                        TextSpan(text: ' ${controller.phoneNumber} '),
                        TextSpan(text: 'otp_description_part2'.tr),
                      ]),
                    ),
                    const SizedBox(height: 24),
                    Row(children: [
                      Expanded(
                        child: Text(
                          'otp_description_wrong_number'.tr,
                          style: Get.textTheme.subtitle1,
                        ),
                      ),
                      GestureDetector(
                        onTap: () => controller.onTapEditButton(),
                        child: Row(children: [
                          SvgPicture.asset(AppIcons.icEdit),
                          const SizedBox(width: 8),
                        ]),
                      ),
                      Text(
                        'otp_number_edit'.tr,
                        style: Get.textTheme.bodyText2!
                            .copyWith(color: AppColors.secondaryColor),
                      ),
                    ]),
                    const SizedBox(height: 24),
                    Row(children: [
                      Expanded(
                        flex: 3,
                        child: TextFormFieldWidget(
                          controller: controller.verifyCodeTEC,
                          keyboardType: TextInputType.number,
                          maxLength: 5,
                          onChanged: (value) =>
                              controller.onChangeOTPCode(value: value),
                          label: Text('otp_textField_hint'.tr),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        flex: 1,
                        child: SizedBox(
                          height: 56,
                          child: OutlineButtonWidget(
                            onTap: () => controller.onTapResendOTPButton(),
                            color: controller.resendOTPEnable.value
                                ? AppColors.primary
                                : AppColors.gray[400]!,
                            child: controller.resendOTPEnable.value
                                ? Text(
                                    'otp_send_sms'.tr,
                                    style: Get.textTheme.bodyText2!
                                        .copyWith(color: AppColors.primary),
                                  )
                                : Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                        Text(
                                          controller.timerText.value,
                                          style: Get.textTheme.bodyText2!
                                              .copyWith(
                                                  color: AppColors.gray[600]),
                                        ),
                                        const SizedBox(width: 8),
                                        SvgPicture.asset(AppIcons.icTimer)
                                      ]),
                          ),
                        ),
                      ),
                    ]),
                    const SizedBox(height: 24),
                    FillButtonWidget(
                      buttonTitle: 'login_button'.tr,
                      onTap: () => controller.onTapVerifyCodeButton(),
                      isLoading: controller.isLoadingConfirmCode.value,
                      enable: controller.isEnableVerifyButton.value,
                    ),
                  ]),
            ),
          ]),
        ),
      ),
    );
  }
}
