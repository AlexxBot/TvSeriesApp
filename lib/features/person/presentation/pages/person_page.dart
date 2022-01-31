import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tvseries_app/core/global/size_constants.dart';
import 'package:tvseries_app/core/global/theme_data.dart';
import 'package:tvseries_app/core/widgets/filter_container_widget.dart';
import 'package:tvseries_app/core/widgets/snack_widget.dart';
import 'package:tvseries_app/core/widgets/will_pop_scope_widget.dart';
import 'package:tvseries_app/features/auth/presentation/pages/menu_page.dart';
import 'package:tvseries_app/features/person/domain/entities/person.dart';
import 'package:tvseries_app/features/person/domain/entities/person_filter.dart';
import 'package:tvseries_app/features/person/presentation/bloc/person_bloc.dart';
import 'package:tvseries_app/features/person/presentation/pages/person_list_widget.dart';
import 'package:tvseries_app/router.dart';

class PersonPage extends StatefulWidget {
  const PersonPage({Key? key}) : super(key: key);

  @override
  _PersonPageState createState() => _PersonPageState();
}

class _PersonPageState extends State<PersonPage> {
  late final PersonBloc _personBloc;
  final _nameController = TextEditingController();

  late List<Person> _personList;

  @override
  void initState() {
    super.initState();
    _personBloc = BlocProvider.of<PersonBloc>(context);
    _personList = [];
  }

  void _searchPerson() {
    _personBloc.add(
        SearchPersonsEvent(filter: PersonFilter(name: _nameController.text)));
  }

  void _goToFavorites() {
    Navigator.of(context).pushNamed(RouteGenerator.favoritesPage);
  }

  /* void _goToConfig() {
    Navigator.of(context).pushNamed(RouteGenerator.configPage);
  } */

  @override
  Widget build(BuildContext context) {
    return WillPopScopeWidget(
      child: Scaffold(
        drawer: const MenuPage(),
        appBar: AppBar(
          title: const Text('People'),
          //leading: IconButton(onPressed: _goToConfig, icon: Icon(Icons.person)),
          actions: [
            IconButton(
              icon: Icon(
                Icons.favorite,
                color: errorColor,
              ),
              onPressed: _goToFavorites,
            )
          ],
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(
                vertical: vspace_m, horizontal: hspace_s),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                FilterContainerWidget(
                  child:
                      /* InputWidget(
                    labelText: 'Name',
                    controller: _nameController,
                  ) */
                      Container(
                    height: 65,
                    padding: const EdgeInsets.symmetric(
                        vertical: vspace_m, horizontal: hspace_s),
                    child: TextFormField(
                      controller: _nameController,
                      //style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                          labelText: "Search People",
                          hintText: "Search People",
                          suffixIcon: IconButton(
                            icon: const Icon(Icons.search),
                            onPressed: _searchPerson,
                          ),
                          border: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                  Radius.circular(borderRadiusInput)))),
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
