import 'package:flutter/material.dart';
import 'package:tvseries_app/core/global/size_constants.dart';

class ImageWidget extends StatelessWidget {
  final String? imageUrl;
  final double scale;
  final double height;
  final double width;
  final bool showNull;
  const ImageWidget(
      {Key? key,
      this.imageUrl,
      this.scale = 1,
      required this.height,
      required this.width,
      this.showNull = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return !showNull && imageUrl == null
        ? const SizedBox(
            height: 0,
            width: 0,
          )
        : /*  Expanded(
            child: FittedBox(
              child: Image.network(imageUrl!),
              fit: BoxFit.fill,
            ),
          ); */
        Container(
            padding: const EdgeInsets.symmetric(
                vertical: vspace_s, horizontal: hspace_m),
            height: height,
            width: width,
            decoration: BoxDecoration(
                boxShadow: [
                  if (imageUrl != null)
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 5,
                      blurRadius: 5,
                      offset: const Offset(0, 3), // changes position of shadow
                    )
                ],
                image: imageUrl != null
                    ? DecorationImage(
                        //filterQuality: FilterQuality.high,
                        //scale: scale,

                        fit: BoxFit.cover,
                        image: NetworkImage(imageUrl!))
                    : null,
                //color: Colors.white,
                borderRadius:
                    const BorderRadius.all(Radius.circular(borderRadiusInput))),
            /* child: imageUrl != null
                ? Image.network(
                    imageUrl ?? '',
                    fit: BoxFit.fitHeight,
                  )
                : null, */
          );
  }
}
