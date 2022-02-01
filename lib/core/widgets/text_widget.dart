import 'package:flutter/material.dart';
import 'package:tvseries_app/core/global/size_constants.dart';

class TextWidget extends StatelessWidget {
  final String text;
  final double fontSize;
  final Color? color;
  final TextAlign? textAlign;
  final FontWeight? fontWeight;
  const TextWidget(this.text,
      {Key? key,
      this.fontSize = fontSize_m,
      this.color,
      this.textAlign,
      this.fontWeight})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: 15,
      overflow: TextOverflow.ellipsis,
      textAlign: textAlign,
      style: TextStyle(
          fontWeight: fontWeight,
          decoration: TextDecoration.none,
          fontFamily: 'Sora',
          color: color ?? Colors.white,
          fontSize: fontSize),
    );
  }
}
