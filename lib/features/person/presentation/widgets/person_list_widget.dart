import 'package:flutter/material.dart';
import 'package:tvseries_app/core/global/size_constants.dart';
import 'package:tvseries_app/features/person/domain/entities/person.dart';
import 'package:tvseries_app/features/person/presentation/widgets/person_item_widget.dart';

class PersonListWidget extends StatelessWidget {
  final List<Person> personList;
  const PersonListWidget({Key? key, required this.personList})
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
          itemCount: personList.length,
          itemBuilder: (BuildContext ctx, index) {
            return PersonItemWidget(
              person: personList[index],
            );
          }),
    );
  }
}
