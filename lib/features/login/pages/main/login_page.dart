import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginPage extends BaseView<LoginController> {
  const LoginPage({Key? key}) : super(key: key);

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
              padding: const EdgeInsets.all(24),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'login_title'.tr,
                      style: Get.textTheme.headline5,
                    ),
                    const SizedBox(height: 32),
                    Text(
                      'login_description'.tr,
                      style: Get.textTheme.subtitle1,
                    ),
                    const SizedBox(height: 24),
                    Form(
                      key: controller.formKey,
                      child: TextFormFieldWidget(
                        controller: controller.phoneNumberTEC,
                        keyboardType: TextInputType.number,
                        maxLength: 11,
                        onChanged: (value) =>
                            controller.onChangePhoneNumber(value: value),
                        validator: (value) => controller.isValid.value
                            ? null
                            : 'لطفا مقدار صحیح وارد فرمائید',
                        // validator: (value) => controller.phoneNumberValidator(value: value),
                        label: Text('login_textField_hint'.tr),
                        hintText: 'login_textField_label'.tr,
                      ),
                    ),
                    const SizedBox(height: 24),
                    FillButtonWidget(
                      buttonTitle: 'login_button'.tr,
                      onTap: () => controller.onTapLogin(),
                      isLoading: controller.isLoading.value,
                      enable: controller.isEnableConfirmButton.value,
                    ),
                  ]),
            ),
          ]),
        ),
      ),
    );
  }
}
