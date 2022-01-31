import 'package:flutter/material.dart';
import 'package:tvseries_app/core/global/size_constants.dart';
import 'package:tvseries_app/core/widgets/text_widget.dart';

class TitleWigdet extends StatefulWidget {
  const TitleWigdet({Key? key}) : super(key: key);

  @override
  _TitleWigdetState createState() => _TitleWigdetState();
}

class _TitleWigdetState extends State<TitleWigdet> {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            const TextWidget('TV Series', fontSize: 3 * fontSize_xxl
                /*  style: TextStyle(
                    fontFamily: "Sora",
                    fontSize: fontSize_l,
                    fontWeight: FontWeight.bold,
                    color: Colors.black) */
                ),
          ],
        ));
  }
}
