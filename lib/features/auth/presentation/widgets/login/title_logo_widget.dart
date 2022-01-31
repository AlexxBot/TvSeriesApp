import 'package:flutter/material.dart';
import 'package:tvseries_app/core/global/size_constants.dart';
import 'package:tvseries_app/core/widgets/text_widget.dart';

class TitleLogoWidget extends StatefulWidget {
  const TitleLogoWidget({Key? key}) : super(key: key);

  @override
  _TitleLogoWidgetState createState() => _TitleLogoWidgetState();
}

class _TitleLogoWidgetState extends State<TitleLogoWidget> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: fontSize_xxl * 3,
        child: Column(
          children: [
            const TextWidget(
              'TV Series',
              /*  style: TextStyle(
                    fontFamily: "Sora",
                    fontSize: fontSize_l,
                    fontWeight: FontWeight.bold,
                    color: Colors.black) */
            ),
            Text(' ALFRED H KNIGHT',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColor,
                    fontSize: fontSize_l * 2)),
          ],
        ) /* RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          children: <TextSpan>[
            TextSpan(
                text: 'Supervision de Transporte',
                style: TextStyle(
                    fontFamily: "Sora",
                    fontSize: fontSize_l,
                    fontWeight: FontWeight.bold,
                    color: Colors.black)),
            TextSpan(
                text: ' ALFRED H KNIGHT',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColor,
                    fontSize: fontSize_xl * 2)),
          ],
        ),
      ), */
        );
  }
}
