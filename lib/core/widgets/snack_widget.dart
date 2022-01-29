import 'package:flutter/material.dart';
import 'package:tvseries_app/core/global/theme_data.dart';

class SnackWidget extends SnackBar {
  static showMessage(BuildContext context, String text,
          {bool isError = false}) =>
      ScaffoldMessenger.of(context).showSnackBar(
        SnackWidget(Text(text),
            backgroundColor: isError
                ? errorColor
                : Theme.of(context).snackBarTheme.backgroundColor),
      );

  final Widget content;
  final Duration duration;
  final String label;
  final Color? backgroundColor;

  const SnackWidget(
    this.content, {
    Key? key,
    this.duration = const Duration(seconds: 3),
    this.label = 'label',
    this.backgroundColor,
  }) : super(
          key: key,
          content: content,
          duration: duration,
          backgroundColor: backgroundColor,
        );
}
