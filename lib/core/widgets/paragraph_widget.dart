import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:tvseries_app/core/global/size_constants.dart';
import 'package:tvseries_app/core/widgets/text_widget.dart';

class ParagraphWidget extends StatelessWidget {
  final String text;
  final double vpadding;
  final double hpadding;
  final double fontSize;
  const ParagraphWidget(this.text,
      {Key? key,
      this.vpadding = vspace_s,
      this.hpadding = hspace_m,
      this.fontSize = fontSize_s})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return /* Padding(
        padding: EdgeInsets.symmetric(vertical: vpadding, horizontal: hpadding),
        child: TextWidget(
          text,
          fontSize: fontSize,
        )); */
        Html(
      shrinkWrap: true,
      data: text,
      style: {
        'p': Style(color: Colors.white, fontSize: FontSize.small, maxLines: 20)
      },
    );
  }
}
