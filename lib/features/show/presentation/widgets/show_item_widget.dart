import 'package:flutter/material.dart';
import 'package:tvseries_app/core/global/size_constants.dart';
import 'package:tvseries_app/core/global/theme_data.dart';
import 'package:tvseries_app/core/widgets/custom_page_route.dart';
import 'package:tvseries_app/core/widgets/text_widget.dart';
import 'package:tvseries_app/features/show/domain/entities/show_item.dart';
import 'package:tvseries_app/features/show/presentation/pages/show_detail_page.dart';
import 'package:tvseries_app/features/show/presentation/widgets/show_image_widget.dart';

class ShowItemWidget extends StatefulWidget {
  final ShowItem showItem;
  const ShowItemWidget({Key? key, required this.showItem}) : super(key: key);

  @override
  State<ShowItemWidget> createState() => _ShowItemWidgetState();
}

class _ShowItemWidgetState extends State<ShowItemWidget> {
  void _goToDetail(BuildContext context) {
    Navigator.of(context)
        .push(CustomPageRoute(ShowDetailPage(showItem: widget.showItem)));
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        _goToDetail(context);
      },
      child: FittedBox(
        child: Column(
          children: [
            ShowImageWidget(imageUrl: widget.showItem.imageUrl),
            //Image.network(showItem.imageUrl ?? ''),
            TextWidget(
              widget.showItem.name,
              fontSize: fontSize_xxl,
              color: textColor,
            ),
          ],
        ),
      ),
    );
  }
}
