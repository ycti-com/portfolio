import 'package:flutter/material.dart';
import '../../helper/theme/app_theme.dart';
import '../../helper/widgets/my_text.dart';

class Info {
  static message(
    String message, {
    GlobalKey<ScaffoldMessengerState>? scaffoldMessengerKey,
    BuildContext? context,
    Duration? duration,
    SnackBarBehavior snackBarBehavior = SnackBarBehavior.fixed,
  }) {
    duration ??= Duration(seconds: 3);
    ThemeData theme = AppTheme.theme;

    SnackBar snackBar = SnackBar(
      duration: duration,
      content: MyText(message, color: theme.colorScheme.onPrimary),
      backgroundColor: theme.colorScheme.primary,
      behavior: snackBarBehavior,
    );

    if (scaffoldMessengerKey != null) {
      scaffoldMessengerKey.currentState!.showSnackBar(snackBar);
    } else if (context != null) {
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else {}
  }

  static error(
    String message, {
    GlobalKey<ScaffoldMessengerState>? scaffoldMessengerKey,
    BuildContext? context,
    Duration? duration,
    SnackBarBehavior snackBarBehavior = SnackBarBehavior.fixed,
  }) {
    duration ??= Duration(seconds: 3);
    ThemeData theme = AppTheme.theme;

    SnackBar snackBar = SnackBar(
      duration: duration,
      content: MyText(message, color: theme.colorScheme.onError),
      backgroundColor: theme.colorScheme.error,
      behavior: snackBarBehavior,
    );

    if (scaffoldMessengerKey != null) {
      scaffoldMessengerKey.currentState!.showSnackBar(snackBar);
    } else if (context != null) {
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else {}
  }
}
