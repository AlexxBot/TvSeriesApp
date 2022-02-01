import 'package:flutter/material.dart';
import 'package:tvseries_app/core/global/theme_data.dart';
import 'package:tvseries_app/core/widgets/button_styled_widget.dart';

Future<bool> confirmation(BuildContext context,
    {String title = 'confirmation',
    String text = 'Want to leave the App?',
    bool isError = false}) async {
  Widget cancelButton = ButtonStyledWidget(
      backgroundColor: Colors.white,
      title: "Cancel",
      onPressed: () => Navigator.pop(context, false));

  Widget continueButton = ButtonStyledWidget(
    title: "Accept",
    onPressed: () => Navigator.pop(context, true),
    withBackground: true,
  );

  AlertDialog alert = AlertDialog(
    backgroundColor: filterBackground,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(18.0),
      /* side: BorderSide(color: Colors.red) */
    ),
    title: Text(
      title,
      style: TextStyle(color: isError ? errorColor : Colors.black),
    ),
    content: Text(text),
    actions: [
      cancelButton,
      continueButton,
    ],
  );

  // show the dialog
  return await showDialog<bool>(
        context: context,
        builder: (BuildContext context) {
          return alert;
        },
      ) ??
      false;
}
