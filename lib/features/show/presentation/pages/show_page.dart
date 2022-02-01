import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tvseries_app/core/global/size_constants.dart';
import 'package:tvseries_app/core/global/theme_data.dart';
import 'package:tvseries_app/core/widgets/button_styled_widget.dart';
import 'package:tvseries_app/core/widgets/custom_page_route.dart';
import 'package:tvseries_app/core/widgets/filter_container_widget.dart';
import 'package:tvseries_app/core/widgets/filter_widget.dart';
import 'package:tvseries_app/core/widgets/input_widget.dart';
import 'package:tvseries_app/core/widgets/snack_widget.dart';
import 'package:tvseries_app/core/widgets/text_widget.dart';
import 'package:tvseries_app/core/widgets/will_pop_scope_widget.dart';
import 'package:tvseries_app/features/auth/presentation/pages/menu_page.dart';
import 'package:tvseries_app/features/show/domain/entities/show_filter.dart';
import 'package:tvseries_app/features/show/domain/entities/show_item.dart';
import 'package:tvseries_app/features/show/presentation/bloc/show_bloc.dart';
import 'package:tvseries_app/features/show/presentation/pages/show_favorite_page.dart';
import 'package:tvseries_app/features/show/presentation/widgets/show_list_widget.dart';
import 'package:tvseries_app/router.dart';

class ShowPage extends StatefulWidget {
  const ShowPage({Key? key}) : super(key: key);

  @override
  _ShowPageState createState() => _ShowPageState();
}

class _ShowPageState extends State<ShowPage> {
  late final ShowBloc _showBloc;
  final _nameController = TextEditingController();
  final _nameFocusNode = FocusNode();

  late List<ShowItem> _showList;

  @override
  void initState() {
    super.initState();
    _showBloc = BlocProvider.of<ShowBloc>(context);
    _showList = [];

    _nameFocusNode.addListener(() {
      if (!_nameFocusNode.hasFocus) {
        _searchShow();
      }
    });
  }

  void _searchShow() {
    _showBloc
        .add(SearchShowsEvent(filter: ShowFilter(name: _nameController.text)));
  }

  void _goToFavorites() {
    Navigator.of(context).pushNamed(RouteGenerator.favoritesPage);
  }

  void _goToConfig() {
    Navigator.of(context).pushNamed(RouteGenerator.configPage);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScopeWidget(
      child: Scaffold(
        drawer: const MenuPage(),
        appBar: AppBar(
          title: const Text('Tv Series'),
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
                  child: Container(
                    height: 65,
                    padding: const EdgeInsets.symmetric(
                        vertical: vspace_m, horizontal: hspace_s),
                    child: TextFormField(
                      controller: _nameController,
                      focusNode: _nameFocusNode,
                      //style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                          labelText: "Search Shows",
                          hintText: "Search Shows",
                          suffixIcon: IconButton(
                            iconSize: 30,
                            color: primaryColor,
                            icon: const Icon(Icons.search),
                            onPressed: _searchShow,
                          ),
                          border: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                  Radius.circular(borderRadiusInput)))),
                    ),
                  ),
                ),
                Expanded(
                    child: BlocListener<ShowBloc, ShowState>(
                        bloc: _showBloc,
                        listener: (context, state) {
                          if (state is ShowsListedState) {
                            _showList = state.list;
                          }
                          if (state is ErrorState) {
                            SnackWidget.showMessage(context, state.message,
                                isError: true);
                          }
                        },
                        child: BlocBuilder<ShowBloc, ShowState>(
                          bloc: _showBloc,
                          builder: (context, state) {
                            if (state is LoadingState) {
                              return const Center(
                                  child: CircularProgressIndicator());
                            } else {
                              if (_showList.isEmpty) {
                                return const Center(
                                    child: TextWidget('No Series Provided'));
                              } else {
                                return ShowListWidget(showList: _showList);
                              }
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
