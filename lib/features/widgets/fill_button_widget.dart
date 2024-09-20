import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

class FillButtonWidget extends StatelessWidget {
  const FillButtonWidget({
    super.key,
    required this.isLoading,
    required this.onTap,
    required this.buttonTitle,
    this.buttonColor = AppColors.primary,
    this.enable = true,
    this.height = 48,
  });

  final bool isLoading;
  final bool enable;
  final VoidCallback onTap;
  final String buttonTitle;
  final Color buttonColor;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (!enable || isLoading) {
          return;
        }
        onTap();
      },
      child: Container(
        height: height,
        width: Get.width,
        decoration: BoxDecoration(
          color: enable ? buttonColor : AppColors.disableColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
          padding: const EdgeInsets.only(
            top: 8.0,
            bottom: 8.0,
          ),
          child: isLoading
              ? SpinKitFadingCircle(
            itemBuilder: (_, int index) {
              return const DecoratedBox(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
              );
            },
            size: 24.0,
          )
              : Center(
            child: Text(
              buttonTitle,
              style: Get.textTheme.labelLarge!.copyWith(color: enable ? AppColors.gray[25] : AppColors.gray[500]),
            ),
          ),
        ),
      ),
    );
  }
}
