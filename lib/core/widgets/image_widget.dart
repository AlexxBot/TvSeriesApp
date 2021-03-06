import 'package:flutter/material.dart';
import 'package:tvseries_app/core/global/size_constants.dart';

class ImageWidget extends StatefulWidget {
  final String? imageUrl;
  final double scale;
  final double height;
  final double width;
  final bool showNull;
  final bool withshadow;
  const ImageWidget(
      {Key? key,
      this.imageUrl,
      this.scale = 1,
      required this.height,
      required this.width,
      this.showNull = true,
      this.withshadow = true})
      : super(key: key);

  @override
  State<ImageWidget> createState() => _ImageWidgetState();
}

class _ImageWidgetState extends State<ImageWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return !widget.showNull && widget.imageUrl == null
        ? const SizedBox(
            height: 200,
            width: 0,
          )
        : Container(
            padding: const EdgeInsets.symmetric(
                vertical: vspace_s, horizontal: hspace_m),
            height: widget.height,
            width: widget.width,
            decoration: BoxDecoration(
                boxShadow: [
                  if (widget.imageUrl != null && widget.withshadow)
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 5,
                      blurRadius: 5,
                      offset: const Offset(0, 3), // changes position of shadow
                    )
                ],
                image: (widget.imageUrl != null && widget.imageUrl != '')
                    ? DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(widget.imageUrl!))
                    : const DecorationImage(
                        opacity: 0.1,
                        //fit: BoxFit.cover,
                        image: AssetImage('assets/images/tv.png'),
                      ),
                borderRadius:
                    const BorderRadius.all(Radius.circular(borderRadiusInput))),
          );
  }
}
