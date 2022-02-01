import 'package:flutter/material.dart';
import 'package:tvseries_app/core/global/size_constants.dart';
//import 'package:flutter_svg/svg.dart';

class LogoWidget extends StatelessWidget {
  const LogoWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
          padding: const EdgeInsets.symmetric(
              vertical: vspace_s, horizontal: hspace_m),
          height: MediaQuery.of(context).size.width / 1.5,
          decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/tv.png'),
              ),
              borderRadius:
                  BorderRadius.all(Radius.circular(borderRadiusInput))))
    ]);
  }
}
