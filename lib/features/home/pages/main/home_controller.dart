import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  HomeController(this._repo);

  final HomeRepository _repo;
  PageController pageController = PageController();
  RxInt bottomNavigatorIndex = 0.obs;

  void onTapBack() {}

  void onTapBottomNavigationItem({required int index}) {
    bottomNavigatorIndex(index);
    pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.linear,
    );
  }
}
