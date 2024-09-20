import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SplashPage extends BaseView<SplashController> {
  const SplashPage({super.key});

  @override
  Widget body() {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFF9694FF),
            Color(0xFF9694FF),
            Color(0xFF2ABFFF),
          ],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: TweenAnimationBuilder<double>(
            duration: const Duration(milliseconds: 800),
            tween: Tween(begin: 0.1, end: 1.6),
            builder: (context, value, child) {
              double newVal = value;
              var ts = Transform.scale(
                scale: newVal,
                child: child,
              );
              return ts;
            },
            curve: Curves.bounceOut,
            child: SizedBox(
              height: 125,
              child: SvgPicture.asset(AppIcons.icLogo),
            ),
          ),
        ),
      ),
    );
  }
}
