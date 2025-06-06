import 'dart:async';

import 'package:flutter/material.dart';
import '../../controller/my_controller.dart';

class CarouselsController extends MyController {
  int simpleCarouselSize = 3, animatedCarouselSize = 3;
  int selectedSimpleCarousel = 0, selectedAnimatedCarousel = 0;

  Timer? timerAnimation;

  final PageController simplePageController = PageController(initialPage: 0);
  final PageController animatedPageController = PageController(initialPage: 0);

  CarouselsController();

  @override
  void onInit() {
    super.onInit();
    timerAnimation = Timer.periodic(Duration(seconds: 5), (Timer timer) {
      if (selectedAnimatedCarousel < animatedCarouselSize - 1) {
        selectedAnimatedCarousel++;
      } else {
        selectedAnimatedCarousel = 0;
      }

      animatedPageController.animateToPage(
        selectedAnimatedCarousel,
        duration: Duration(milliseconds: 600),
        curve: Curves.ease,
      );
      update();
    });
  }

  void onChangeSimpleCarousel(int value) {
    selectedSimpleCarousel = value;
    update();
  }

  void onChangeAnimatedCarousel(int value) {
    selectedAnimatedCarousel = value;
    update();
  }

  @override
  void dispose() {
    super.dispose();
    timerAnimation?.cancel();
    simplePageController.dispose();
    animatedPageController.dispose();
  }
}
