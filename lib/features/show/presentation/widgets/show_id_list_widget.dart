import 'package:flutter/material.dart';
import 'package:tvseries_app/core/global/size_constants.dart';
import 'package:tvseries_app/features/show/domain/entities/show_item.dart';
import 'package:tvseries_app/features/show/presentation/widgets/show_id_item_widget.dart';
import 'package:tvseries_app/features/show/presentation/widgets/show_item_widget.dart';

class ShowIdListWidget extends StatefulWidget {
  final List<String> showIdList;
  const ShowIdListWidget({Key? key, required this.showIdList})
      : super(key: key);

  @override
  State<ShowIdListWidget> createState() => _ShowIdListWidgetState();
}

class _ShowIdListWidgetState extends State<ShowIdListWidget> {
  int pageNum = 1;
  bool isPageLoading = false;
  late ScrollController controller;
  int totalRecord = 0;

  @override
  void initState() {
    super.initState();
    controller = ScrollController()..addListener(_scrollListener);
  }

  @override
  void dispose() {
    controller.removeListener(_scrollListener);
    super.dispose();
  }

  _scrollListener() {}

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      child: /* ListView.builder(
      itemCount: widget.showList.length,
      itemBuilder: (context, index) {
        return ListTile(
            title: Text(
          widget.showList[index].name,
        ));
      },
    ) */
          GridView.builder(
              padding: const EdgeInsets.symmetric(
                  vertical: vspace_m, horizontal: hspace_m),
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 200,
                  childAspectRatio: 3 / 4.5,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 10),
              itemCount: widget.showIdList.length,
              itemBuilder: (BuildContext ctx, index) {
                return ShowIdItemWidget(
                  showId: widget.showIdList[index],
                );
              }),
    );
  }
}
