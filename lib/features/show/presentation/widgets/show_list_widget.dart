import 'package:flutter/material.dart';
import 'package:tvseries_app/core/global/size_constants.dart';
import 'package:tvseries_app/features/show/domain/entities/show_item.dart';
import 'package:tvseries_app/features/show/presentation/widgets/show_id_item_widget.dart';
import 'package:tvseries_app/features/show/presentation/widgets/show_item_widget.dart';

class ShowListWidget extends StatefulWidget {
  final List<ShowItem> showList;
  final List<String> idList;
  const ShowListWidget(
      {Key? key, this.showList = const [], this.idList = const []})
      : super(key: key);

  @override
  State<ShowListWidget> createState() => _ShowListWidgetState();
}

class _ShowListWidgetState extends State<ShowListWidget> {
  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      child: GridView.builder(
          padding: const EdgeInsets.symmetric(
              vertical: vspace_m, horizontal: hspace_m),
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 200,
              childAspectRatio: 3 / 4.5,
              crossAxisSpacing: 20,
              mainAxisSpacing: 10),
          itemCount: widget.showList.isNotEmpty
              ? widget.showList.length
              : widget.idList.length,
          itemBuilder: (BuildContext ctx, index) {
            if (widget.showList.isNotEmpty) {
              return ShowItemWidget(
                showItem: widget.showList[index],
              );
            } else {
              return ShowIdItemWidget(
                showId: widget.idList[index],
              );
            }
          }),
    );
  }
}
