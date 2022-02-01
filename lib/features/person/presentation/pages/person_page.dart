import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tvseries_app/core/global/size_constants.dart';
import 'package:tvseries_app/core/global/theme_data.dart';
import 'package:tvseries_app/core/widgets/filter_container_widget.dart';
import 'package:tvseries_app/core/widgets/input_widget.dart';
import 'package:tvseries_app/core/widgets/snack_widget.dart';
import 'package:tvseries_app/core/widgets/text_widget.dart';
import 'package:tvseries_app/core/widgets/will_pop_scope_widget.dart';
import 'package:tvseries_app/features/auth/presentation/pages/menu_page.dart';
import 'package:tvseries_app/features/person/domain/entities/person.dart';
import 'package:tvseries_app/features/person/domain/entities/person_filter.dart';
import 'package:tvseries_app/features/person/presentation/bloc/person_bloc.dart';
import 'package:tvseries_app/features/person/presentation/widgets/person_list_widget.dart';
import 'package:tvseries_app/router.dart';

class PersonPage extends StatefulWidget {
  const PersonPage({Key? key}) : super(key: key);

  @override
  _PersonPageState createState() => _PersonPageState();
}

class _PersonPageState extends State<PersonPage> {
  late final PersonBloc _personBloc;
  final _nameController = TextEditingController();
  final _nameFocusNode = FocusNode();
  late List<Person> _personList;

  @override
  void initState() {
    super.initState();
    _personBloc = BlocProvider.of<PersonBloc>(context);
    _personList = [];

    _nameFocusNode.addListener(() {
      if (!_nameFocusNode.hasFocus) {
        _searchPerson();
      }
    });
  }

  void _searchPerson() {
    _personBloc.add(
        SearchPersonsEvent(filter: PersonFilter(name: _nameController.text)));
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScopeWidget(
      child: Scaffold(
        drawer: const MenuPage(),
        appBar: AppBar(
          title: const Text('People'),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(
                vertical: vspace_m, horizontal: hspace_s),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                FilterContainerWidget(
                  child: Container(
                    height: 65,
                    padding: const EdgeInsets.symmetric(
                        vertical: vspace_m, horizontal: hspace_s),
                    child: InputWidget(
                      controller: _nameController,
                      focusNode: _nameFocusNode,
                      label: "Search by name",
                      onPressed: _searchPerson,
                    ),
                  ),
                ),
                Expanded(
                    child: BlocListener<PersonBloc, PersonState>(
                        bloc: _personBloc,
                        listener: (context, state) {
                          if (state is PersonsListedState) {
                            _personList = state.list;
                          }
                          if (state is ErrorState) {
                            SnackWidget.showMessage(context, state.message,
                                isError: true);
                          }
                        },
                        child: BlocBuilder<PersonBloc, PersonState>(
                          bloc: _personBloc,
                          builder: (context, state) {
                            if (state is LoadingState) {
                              return const Center(
                                  child: CircularProgressIndicator());
                            }
                            if (_personList.isEmpty) {
                              return Center(
                                child: Container(
                                  decoration: const BoxDecoration(
                                    image: DecorationImage(
                                      opacity: 0.2,
                                      image: AssetImage('assets/images/tv.png'),
                                    ),
                                  ),
                                ),
                              );
                            } else {
                              return PersonListWidget(personList: _personList);
                            }
                          },
                        )))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
