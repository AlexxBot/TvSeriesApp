import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:tvseries_app/core/global/size_constants.dart';
import 'package:http/http.dart' as http;
import 'package:tvseries_app/core/network/network_info.dart';
import 'package:tvseries_app/injections.dart';

class ImageWidget extends StatefulWidget {
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
  State<ImageWidget> createState() => _ImageWidgetState();
}

class _ImageWidgetState extends State<ImageWidget> {
  //late Future<File> image;

  @override
  void initState() {
    super.initState();
    /* if (widget.imageUrl != '') {
      getImageUrl();
    } */
  }

  Future<File> getImageUrl() async {
    //final uri = Uri.parse(widget.imageUrl!);
    //return File.fromUri(uri);
    final uri = Uri.parse(widget.imageUrl!);
    final responseData = await http.get(uri);
    final uint8list = responseData.bodyBytes;
    var buffer = uint8list.buffer;
    ByteData byteData = ByteData.view(buffer);
    var tempDir = await getTemporaryDirectory();
    File file = await File('${tempDir.path}/${widget.imageUrl}').writeAsBytes(
        buffer.asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));
    return file;
  }

  @override
  Widget build(BuildContext context) {
    return !widget.showNull && widget.imageUrl == null
        ? const SizedBox(
            height: 0,
            width: 0,
          )
        : widget.imageUrl != ''
            ? FutureBuilder(
                future: getImageUrl(),
                builder: (BuildContext context, AsyncSnapshot<File> snapshot) {
                  if (snapshot.hasData) {
                    return Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: vspace_s, horizontal: hspace_m),
                      height: widget.height,
                      width: widget.width,
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.3),
                              spreadRadius: 5,
                              blurRadius: 5,
                              offset: const Offset(
                                  0, 3), // changes position of shadow
                            )
                          ],
                          image: DecorationImage(
                              //filterQuality: FilterQuality.high,
                              //scale: scale,

                              fit: BoxFit.cover,
                              image: FileImage(snapshot.data!, scale: 0.1)),

                          //color: Colors.white,
                          borderRadius: const BorderRadius.all(
                              Radius.circular(borderRadiusInput))),
                      /* child: imageUrl != null
                ? Image.network(
                    imageUrl ?? '',
                    height: height,
                    width: width,

                    fit: BoxFit.fitHeight,
                  )
                : null, */
                    );
                  } else {
                    return CircularProgressIndicator();
                  }
                })
            : SizedBox(
                height: 200,
                width: 150,
              );

    /* Container(
            padding: const EdgeInsets.symmetric(
                vertical: vspace_s, horizontal: hspace_m),
            height: widget.height,
            width: widget.width,
            decoration: BoxDecoration(
                boxShadow: [
                  if (widget.imageUrl != null)
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 5,
                      blurRadius: 5,
                      offset: const Offset(0, 3), // changes position of shadow
                    )
                ],
                image: widget.imageUrl != null
                    ? DecorationImage(
                        //filterQuality: FilterQuality.high,
                        //scale: scale,

                        fit: BoxFit.cover,
                        image: NetworkImage(widget.imageUrl!, scale: 0.1))
                    : null,
                //color: Colors.white,
                borderRadius:
                    const BorderRadius.all(Radius.circular(borderRadiusInput))),
            /* child: imageUrl != null
                ? Image.network(
                    imageUrl ?? '',
                    height: height,
                    width: width,

                    fit: BoxFit.fitHeight,
                  )
                : null, */
          ); */
  }
}
