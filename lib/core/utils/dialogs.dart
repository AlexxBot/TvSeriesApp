import 'package:flutter/material.dart';
import 'package:tvseries_app/core/global/theme_data.dart';
import 'package:tvseries_app/core/widgets/button_styled_widget.dart';

Future<bool> confirmation(BuildContext context,
    {String title = 'confirmation',
    String text = 'Want to leave the App?',
    bool isError = false}) async {
  // set up the buttons
  /* Widget cancelButton = TextButton(
    child: Text("Cancelar"),
    onPressed: () => Navigator.pop(context, false),
  ); */
  Widget cancelButton = ButtonStyledWidget(
      title: "Cancel", onPressed: () => Navigator.pop(context, false));

  Widget continueButton = ButtonStyledWidget(
    title: "Acept",
    onPressed: () => Navigator.pop(context, true),
    withBackground: true,
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    //backgroundColor: filterBackground.w,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(18.0),
      /* side: BorderSide(color: Colors.red) */
    ),
    title: Text(
      title,
      style: TextStyle(color: isError ? errorColor : colorText),
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
