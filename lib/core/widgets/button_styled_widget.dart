import 'package:flutter/material.dart';
import 'package:tvseries_app/core/global/size_constants.dart';
import 'package:tvseries_app/core/utils/phone_actions_utils.dart';

class ButtonStyledWidget extends StatefulWidget {
  final String title;
  final Color backgroundColor;
  final Color textColor;
  final double textSize;
  final GestureTapCallback onPressed;
  final bool withBackground;
  final double vOutPadding;
  final double hOutPadding;
  final double vInPadding;
  final double hInPadding;

  const ButtonStyledWidget({
    Key? key,
    required this.title,
    this.backgroundColor = Colors.blue,
    this.textColor = Colors.white,
    this.textSize = 14,
    required this.onPressed,
    this.withBackground = false,
    this.vOutPadding = vspace_s,
    this.hOutPadding = hspace_l,
    this.vInPadding = vspace_s,
    this.hInPadding = hspace_s,
  }) : super(key: key);

  @override
  ButtonStyledWidgetState createState() => ButtonStyledWidgetState();
}

class ButtonStyledWidgetState extends State<ButtonStyledWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextButton(
        child: Padding(
          padding: EdgeInsets.symmetric(
              vertical: widget.vOutPadding, horizontal: widget.hOutPadding),
          child: Text(widget.title,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: widget.withBackground
                    ? widget.textColor
                    : Theme.of(context).primaryColor,
                fontSize: widget.textSize,
              )),
        ),
        onPressed: () {
          FocusScope.of(context).requestFocus(FocusNode());
          vibrate();
          widget.onPressed();
        },
        style: ButtonStyle(
          padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.symmetric(
              vertical: widget.vInPadding, horizontal: widget.hInPadding)),
          backgroundColor: MaterialStateProperty.resolveWith<Color>(
            (Set<MaterialState> states) {
              if (states.contains(MaterialState.pressed))
                return widget.withBackground
                    ? Theme.of(context).primaryColor.withOpacity(0.5)
                    : Theme.of(context).backgroundColor.withOpacity(0.5);
              return widget.withBackground
                  ? Theme.of(context).primaryColor.withOpacity(1)
                  : Colors.white
                      .withOpacity(0.5); // Use the component's default.
            },
          ),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(borderRadiusModal),
                  side: BorderSide(color: Theme.of(context).primaryColor))),
        ));
  }
}
