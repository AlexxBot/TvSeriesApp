import 'package:flutter/material.dart';
import 'package:tvseries_app/core/global/theme_data.dart';
import 'package:tvseries_app/features/show/domain/entities/show_item.dart';

class ShowListWidget extends StatelessWidget {
  final List<ShowItem> showList;
  const ShowListWidget({Key? key, required this.showList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return ListTile(
            title: Text(
          showList[index].name,
        ));
      },
    );
  }
}
