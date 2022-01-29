import 'package:flutter/material.dart';
import 'package:tvseries_app/core/global/size_constants.dart';

class ShowImageWidget extends StatelessWidget {
  final String? imageUrl;
  const ShowImageWidget({Key? key, this.imageUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: 150,
      //padding: EdgeInsets.all(1),
      decoration: BoxDecoration(
          image: imageUrl != null
              ? DecorationImage(
                  fit: BoxFit.cover, image: NetworkImage(imageUrl!))
              : null,
          color: Colors.black,
          borderRadius:
              const BorderRadius.all(Radius.circular(borderRadiusInput))),
      //child: Image.network(showItem.imageUrl ?? ''),
    );
  }
}
