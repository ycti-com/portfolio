import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/my_controller.dart';
import '../../helper/extensions/string.dart';
import '../../helper/theme/admin_theme.dart';
import '../../helper/widgets/my_button.dart';
import '../../helper/widgets/my_spacing.dart';
import '../../helper/widgets/my_text.dart';

class NotificationController extends MyController {
  final TickerProvider ticker;
  Timer? _timer;

  TextEditingController toastTitleController = TextEditingController(text: "WebUi is awesome");
  ContentThemeColor selectedColor = ContentThemeColor.primary;
  SnackBarBehavior selectedBehavior = SnackBarBehavior.floating;
  late AnimationController animationController = AnimationController(vsync: ticker, duration: Duration(seconds: 20));

  bool showCloseIcon = true, showOkAction = true, showBanner = false, showLeadingIcon = true, sticky = false;

  NotificationController(this.ticker);

  void setBannerType(bool value) {
    showBanner = value;
    update();
  }

  void onChangeColor(ContentThemeColor? value) {
    if (value != null) {
      selectedColor = value;
      update();
    }
  }

  void onChangeBehavior(SnackBarBehavior? value) {
    if (value != null) {
      selectedBehavior = value;
      update();
    }
  }

  void onChangeShowCloseIcon(bool? value) {
    if (value != null) {
      showCloseIcon = value;
      update();
    }
  }

  void onChangeShowOkAction(bool? value) {
    if (value != null) {
      showOkAction = value;
      update();
    }
  }

  void onChangeShowLeadingIcon(bool? value) {
    if (value != null) {
      showLeadingIcon = value;
      update();
    }
  }

  void onChangeSticky(bool? value) {
    if (value != null) {
      sticky = value;
      update();
    }
  }

  //Show snackbar
  void show() {
    if (showBanner) {
      showMaterialBanner();
    } else {
      showSnackbar();
    }
  }

  void showMaterialBanner() {
    String text = toastTitleController.text.nullIfEmpty ?? "Please set title";
    Color backgroundColor = selectedColor.color;
    Color color = selectedColor.onColor;

    List<Widget> actions = [];
    if (showCloseIcon) {
      actions.add(
        MyButton.text(
          onPressed: () {
            ScaffoldMessenger.of(Get.context!).hideCurrentMaterialBanner();
          },
          padding: MySpacing.x(8),
          splashColor: color.withValues(alpha: 0.1),
          child: MyText.labelMedium('Dismiss', color: color),
        ),
      );
    } else {
      actions.add(MySpacing.empty());
    }

    Widget? leadingIcon;
    if (showLeadingIcon) {
      leadingIcon = Icon(Icons.info_outline, color: color, size: 20);
    }

    MaterialBanner banner = MaterialBanner(
      content: MyText.labelMedium(text, color: color),
      padding: MySpacing.x(24),
      leading: leadingIcon,
      actions: actions,
      overflowAlignment: OverflowBarAlignment.center,
      forceActionsBelow: false,
      backgroundColor: backgroundColor,
    );

    ScaffoldMessenger.of(Get.context!).hideCurrentMaterialBanner();
    ScaffoldMessenger.of(Get.context!).showMaterialBanner(banner);

    _timer?.cancel();
    if (!sticky) {
      _timer = Timer(Duration(seconds: 3), () {
        ScaffoldMessenger.of(Get.context!).hideCurrentMaterialBanner();
      });
    }
  }

  void showSnackbar() {
    String text = toastTitleController.text.nullIfEmpty ?? "Please set title";
    Color backgroundColor = selectedColor.color;
    Color color = selectedColor.onColor;
    double? width = selectedBehavior == SnackBarBehavior.fixed ? null : 300;
    Duration duration = Duration(seconds: sticky ? 10000 : 3);

    SnackBarAction? action;
    if (showOkAction) {
      action = SnackBarAction(
        label: "Ok",
        onPressed: () => ScaffoldMessenger.of(Get.context!).hideCurrentSnackBar(),
        textColor: color,
      );
    }

    SnackBar snackBar = SnackBar(
      width: width,
      behavior: selectedBehavior,
      duration: duration,
      showCloseIcon: showCloseIcon,
      closeIconColor: color,
      action: action,
      animation: Tween<double>(begin: 0, end: 300).animate(animationController),
      content: MyText.labelLarge(text, color: color),
      backgroundColor: backgroundColor,
    );
    ScaffoldMessenger.of(Get.context!).hideCurrentSnackBar();
    ScaffoldMessenger.of(Get.context!).showSnackBar(snackBar);
  }

  @override
  void dispose() {
    super.dispose();
    _timer?.cancel();
    try {
      ScaffoldMessenger.of(Get.context!).hideCurrentSnackBar();
      ScaffoldMessenger.of(Get.context!).hideCurrentMaterialBanner();
      // ignore: empty_catches
    } catch (e) {}
  }
}
