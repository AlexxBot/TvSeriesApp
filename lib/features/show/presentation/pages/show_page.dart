import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tvseries_app/core/global/size_constants.dart';
import 'package:tvseries_app/core/widgets/filter_widget.dart';
import 'package:tvseries_app/core/widgets/input_widget.dart';
import 'package:tvseries_app/core/widgets/snack_widget.dart';
import 'package:tvseries_app/features/show/domain/entities/show_filter.dart';
import 'package:tvseries_app/features/show/domain/entities/show_item.dart';
import 'package:tvseries_app/features/show/presentation/bloc/show_bloc.dart';
import 'package:tvseries_app/features/show/presentation/widgets/show_list_widget.dart';

class ShowPage extends StatefulWidget {
  const ShowPage({Key? key}) : super(key: key);

  @override
  _ShowPageState createState() => _ShowPageState();
}

class _ShowPageState extends State<ShowPage> {
  late final ShowBloc _showBloc;
  final _nameController = TextEditingController();

  late List<ShowItem> _showList;

  @override
  void initState() {
    super.initState();
    _showBloc = BlocProvider.of<ShowBloc>(context);
    _showList = [];
  }

  void _searchShow() {
    _showBloc
        .add(SearchShowsEvent(filter: ShowFilter(name: _nameController.text)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /* appBar: AppBar(
        title: const Text('Shows'),
      ), */
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
              vertical: vspace_m, horizontal: hspace_s),
          child: Column(
            children: [
              FilterWidget(children: [
                InputWidget(
                  labelText: 'Name',
                  controller: _nameController,
                )
              ], onPressed: _searchShow),
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
