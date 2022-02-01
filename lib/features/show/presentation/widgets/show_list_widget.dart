import 'package:flutter/material.dart';
import 'package:tvseries_app/core/global/size_constants.dart';
import 'package:tvseries_app/features/show/domain/entities/show_item.dart';
import 'package:tvseries_app/features/show/presentation/widgets/show_id_item_widget.dart';
import 'package:tvseries_app/features/show/presentation/widgets/show_item_widget.dart';

class ShowListWidget extends StatelessWidget {
  final List<ShowItem> showList;
  final List<String> idList;
  const ShowListWidget(
      {Key? key, this.showList = const [], this.idList = const []})
      : super(key: key);

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
          itemCount: showList.isNotEmpty ? showList.length : idList.length,
          itemBuilder: (BuildContext ctx, index) {
            if (showList.isNotEmpty) {
              return ShowItemWidget(
                showItem: showList[index],
              );
            } else {
              return ShowIdItemWidget(
                showId: idList[index],
              );
            }
          }),
    );
  }
}
