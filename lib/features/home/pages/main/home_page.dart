import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class HomePage extends BaseView<HomeController> {
  const HomePage({super.key});

  @override
  Widget body() {
    return Scaffold(
      body: Column(children: [
        Expanded(
          child: PageView(
              controller: controller.pageController,
              physics: const NeverScrollableScrollPhysics(),
              children: const [
                TodayPage(),
                PackagePage(),
                WorkoutPage(),
                MealPage(),
                MorePage(),
              ]),
        ),
        BottomNavigationBar(
            currentIndex: controller.bottomNavigatorIndex.value,
            selectedIconTheme: const IconThemeData(
              color: AppColors.primary,
            ),
            unselectedIconTheme: IconThemeData(color: AppColors.gray[400]),
            onTap: (index) =>
                controller.onTapBottomNavigationItem(index: index),
            showUnselectedLabels: true,
            unselectedItemColor: AppColors.gray[600],
            selectedItemColor: AppColors.primary,
            selectedLabelStyle: Get.textTheme.overline,
            unselectedLabelStyle: Get.textTheme.overline,
            items: [
              BottomNavigationBarItem(
                icon: SvgPicture.asset(AppIcons.icToday),
                label: 'امروز',
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(AppIcons.icPackage),
                label: 'پکیج',
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(AppIcons.icWorkoutUnselected),
                label: 'تمرین',
                activeIcon: SvgPicture.asset(AppIcons.icWorkoutSelected),
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(AppIcons.icFood),
                label: 'تغذیه',
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(AppIcons.icMore),
                label: 'بیشتر',
              ),
            ])
      ]),
    );
  }

  @override
  bool onWillPop() {
    controller.onTapBack();
    return false;
  }
}
