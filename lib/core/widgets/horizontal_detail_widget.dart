import 'package:flutter/material.dart';
import 'package:tvseries_app/core/global/size_constants.dart';

class HorizontalDetailWidget extends StatelessWidget {
  final String name;
  final String value;
  final double fontSizeName;
  final double fontSizeValue;
  final Color? color;
  final TextAlign? textAlign;
  const HorizontalDetailWidget(
      {Key? key,
      this.name = '',
      this.value = '',
      this.color,
      this.fontSizeName = fontSize_s,
      this.fontSizeValue = fontSize_m,
      this.textAlign})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.symmetric(vertical: vspace_s, horizontal: hspace_s),
      child: RichText(
          text: TextSpan(
              text: '$name : ',
              style: TextStyle(color: color, fontSize: fontSizeName),
              children: <TextSpan>[
            TextSpan(
              text: value,
              style: TextStyle(
                  color: color,
                  fontSize: fontSizeValue,
                  fontWeight: FontWeight.w600),
            ),
          ])),
    );
  }
}
