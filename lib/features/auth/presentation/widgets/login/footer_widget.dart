import 'package:flutter/material.dart';
import 'package:tvseries_app/core/global/size_constants.dart';
import 'package:tvseries_app/core/widgets/text_widget.dart';

class FooterWidget extends StatelessWidget {
  const FooterWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const TextWidget(
      "Developed by Alex Ttito Cornejo",
      fontSize: fontSize_s,
      fontWeight: FontWeight.w100,
    );
  }
}
