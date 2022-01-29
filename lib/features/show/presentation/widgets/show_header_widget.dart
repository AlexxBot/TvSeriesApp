import 'package:flutter/material.dart';
import 'package:tvseries_app/core/widgets/text_widget.dart';
import 'package:tvseries_app/features/show/domain/entities/show_item.dart';
import 'package:tvseries_app/features/show/presentation/widgets/show_image_widget.dart';

class ShowHeaderWidget extends StatelessWidget {
  final ShowItem showItem;
  const ShowHeaderWidget({Key? key, required this.showItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        //constraints: const BoxConstraints.expand(),
        width: double.infinity,
        child: Stack(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: ShowImageWidget(imageUrl: showItem.imageUrl),
            ),
            Align(
              alignment: Alignment.topRight,
              child: TextWidget(showItem.name),
            )
          ],
        ));
  }
}
