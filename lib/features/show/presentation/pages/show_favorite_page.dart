import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tvseries_app/core/global/size_constants.dart';
import 'package:tvseries_app/core/widgets/snack_widget.dart';
import 'package:tvseries_app/core/widgets/text_widget.dart';
import 'package:tvseries_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:tvseries_app/features/show/presentation/widgets/show_list_widget.dart';

class ShowFavoritePage extends StatefulWidget {
  const ShowFavoritePage({Key? key}) : super(key: key);

  @override
  _ShowFavoritePageState createState() => _ShowFavoritePageState();
}

class _ShowFavoritePageState extends State<ShowFavoritePage> {
  late final AuthBloc _authBloc;
  late List<String> _idList;

  @override
  void initState() {
    super.initState();
    _authBloc = BlocProvider.of<AuthBloc>(context);
    _idList = [];
    _getFavorites();
  }

  Future<void> _getFavorites() async {
    _authBloc.add(const GetFavoritesEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorites'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
              vertical: vspace_m, horizontal: hspace_s),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                  child: RefreshIndicator(
                onRefresh: () => _getFavorites(),
                child: BlocListener<AuthBloc, AuthState>(
                    bloc: _authBloc,
                    listener: (context, state) {
                      if (state is FavoritesRetrivedState) {
                        _idList = state.idList;
                      }
                      if (state is ErrorState) {
                        SnackWidget.showMessage(context, state.message,
                            isError: true);
                      }
                    },
                    child: BlocBuilder<AuthBloc, AuthState>(
                      bloc: _authBloc,
                      builder: (context, state) {
                        if (state is LoadingState) {
                          return const Center(
                              child: CircularProgressIndicator());
                        }
                        if (_idList.isEmpty) {
                          return const Center(
                              child: TextWidget('There is no favorites yet'));
                        } else {
                          return ShowListWidget(idList: _idList);
                        }
                      },
                    )),
              ))
            ],
          ),
        ),
      ),
    );
  }
}
