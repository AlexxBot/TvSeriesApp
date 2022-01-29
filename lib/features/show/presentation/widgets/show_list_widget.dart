import 'package:flutter/material.dart';
import 'package:tvseries_app/core/global/size_constants.dart';
import 'package:tvseries_app/features/show/domain/entities/show_item.dart';
import 'package:tvseries_app/features/show/presentation/widgets/show_item_widget.dart';

class ShowListWidget extends StatefulWidget {
  final List<ShowItem> showList;
  const ShowListWidget({Key? key, required this.showList}) : super(key: key);

  @override
  State<ShowListWidget> createState() => _ShowListWidgetState();
}

class _ShowListWidgetState extends State<ShowListWidget> {
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

  _scrollListener() {
    /* if (totalRecord == widget.showList.length) {
      return;
    }
    //print(controller.position.extentAfter);
    if (controller.position.extentAfter <= 0 && isPageLoading == false) {
      _callAPIToGetListOfData();
    } */
  }

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
              itemCount: widget.showList.length,
              itemBuilder: (BuildContext ctx, index) {
                return ShowItemWidget(
                  showItem: widget.showList[index],
                );
              }),
    );
  }
}
