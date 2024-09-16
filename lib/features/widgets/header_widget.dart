import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({
    Key? key,
    this.onTapBackButton,
    this.bottomPadding = 24,
    required this.title,
  }) : super(key: key);
  final VoidCallback? onTapBackButton;
  final double bottomPadding;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: bottomPadding,
        right: 8,
        left: 8,
      ),
      child: SizedBox(
        height: 48,
        child: Row(children: [
          Expanded(
            flex: 1,
            child: Align(
              alignment: Alignment.centerRight,
              child: IconButton(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onPressed: () {
                  if (onTapBackButton != null) {
                    onTapBackButton!();
                  } else {
                    Get.back();
                  }
                },
                icon: SvgPicture.asset(AppIcons.icBackHome),
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              title,
              style:
                  Get.textTheme.subtitle1!.copyWith(color: AppColors.gray[900]),
              textAlign: TextAlign.center,
            ),
          ),
          const Expanded(
            flex: 1,
            child: SizedBox(),
          ),
        ]),
      ),
    );
  }
}
