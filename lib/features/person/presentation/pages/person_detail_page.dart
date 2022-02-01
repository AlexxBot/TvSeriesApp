import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tvseries_app/core/global/size_constants.dart';
import 'package:tvseries_app/core/global/theme_data.dart';
import 'package:tvseries_app/core/widgets/text_widget.dart';

import 'package:tvseries_app/features/person/domain/entities/person.dart';
import 'package:tvseries_app/features/person/presentation/bloc/person_bloc.dart';
import 'package:tvseries_app/features/person/presentation/widgets/person_portrait_widget.dart';
import 'package:tvseries_app/features/show/domain/entities/show_item.dart';

import 'package:tvseries_app/features/show/presentation/widgets/show_list_widget.dart';

class PersonDetailPage extends StatefulWidget {
  final Person person;
  const PersonDetailPage({Key? key, required this.person}) : super(key: key);

  @override
  _PersonDetailPageState createState() => _PersonDetailPageState();
}

class _PersonDetailPageState extends State<PersonDetailPage> {
  late final PersonBloc _showBloc;
  late List<ShowItem> _showList;

  //late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _showBloc = BlocProvider.of<PersonBloc>(context);
    _showList = [];
    _showBloc.add(GetShowListEvent(id: widget.person.id.toString()));
    //_tabController = new TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.person.name),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
              vertical: vspace_m, horizontal: hspace_s),
          child: Column(
            children: [
              PersonPortraitWidget(person: widget.person),
              Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(vspace_s),
                  color: primaryColor,
                  child: Center(
                      child:
                          const TextWidget('Series', fontSize: fontSize_xxl))),
              Expanded(
                  child: BlocListener<PersonBloc, PersonState>(
                      bloc: _showBloc,
                      listener: (context, state) {
                        if (state is ShowsListedState) {
                          _showList = state.list;
                        }
                      },
                      child: BlocBuilder<PersonBloc, PersonState>(
                        bloc: _showBloc,
                        builder: (context, state) {
                          if (state is LoadingState) {
                            return const Center(
                                child: CircularProgressIndicator());
                          } else {
                            return ShowListWidget(showList: _showList);
                          }
                        },
                      )))
            ],
          ),
        ),
      ),
    );
  }
}
