import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tvseries_app/core/global/size_constants.dart';
import 'package:tvseries_app/core/global/theme_data.dart';
import 'package:tvseries_app/core/widgets/custom_page_route.dart';
import 'package:tvseries_app/core/widgets/text_widget.dart';
import 'package:tvseries_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:tvseries_app/features/person/domain/entities/person.dart';
import 'package:tvseries_app/features/person/presentation/pages/person_detail_page.dart';
import 'package:tvseries_app/core/widgets/image_widget.dart';

class PersonItemWidget extends StatefulWidget {
  final Person person;
  const PersonItemWidget({Key? key, required this.person}) : super(key: key);

  @override
  State<PersonItemWidget> createState() => _PersonItemWidgetState();
}

class _PersonItemWidgetState extends State<PersonItemWidget> {
  late AuthBloc _authBloc;

  @override
  void initState() {
    super.initState();
    _authBloc = BlocProvider.of<AuthBloc>(context);
    _authBloc.add(ExistFavoriteEvent(id: widget.person.id.toString()));
  }

  void _goToDetail(BuildContext context) {
    Navigator.of(context)
        .push(CustomPageRoute(PersonDetailPage(person: widget.person)));
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        _goToDetail(context);
      },
      child: Column(
        children: [
          Stack(
            children: [
              ImageWidget(
                  imageUrl: widget.person.imageUrl, height: 200, width: 150),
            ],
          ),
          const SizedBox(
            height: vspace_s,
          ),
          TextWidget(
            widget.person.name,
            fontSize: fontSize_l,
            color: textColor,
          ),
        ],
      ),
    );
  }
}
