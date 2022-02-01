import 'package:flutter/material.dart';
import 'package:tvseries_app/core/global/size_constants.dart';
import 'package:tvseries_app/features/person/domain/entities/person.dart';
import 'package:tvseries_app/features/person/presentation/widgets/person_item_widget.dart';

class PersonListWidget extends StatefulWidget {
  final List<Person> personList;
  const PersonListWidget({Key? key, required this.personList})
      : super(key: key);

  @override
  State<PersonListWidget> createState() => _PersonListWidgetState();
}

class _PersonListWidgetState extends State<PersonListWidget> {
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
    /* if (totalRecord == widget.personList.length) {
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
      itemCount: widget.personList.length,
      itemBuilder: (context, index) {
        return ListTile(
            title: Text(
          widget.personList[index].name,
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
              itemCount: widget.personList.length,
              itemBuilder: (BuildContext ctx, index) {
                return PersonItemWidget(
                  person: widget.personList[index],
                );
              }),
    );
  }
}
