import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tvseries_app/core/global/size_constants.dart';
import 'package:tvseries_app/core/global/theme_data.dart';
import 'package:tvseries_app/core/widgets/check_widget.dart';
import 'package:tvseries_app/core/widgets/filter_container_widget.dart';
import 'package:tvseries_app/core/widgets/snack_widget.dart';
import 'package:tvseries_app/core/widgets/text_widget.dart';
import 'package:tvseries_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:tvseries_app/features/show/presentation/widgets/show_id_list_widget.dart';

class ShowFavoritePage extends StatefulWidget {
  const ShowFavoritePage({Key? key}) : super(key: key);

  @override
  _ShowFavoritePageState createState() => _ShowFavoritePageState();
}

class _ShowFavoritePageState extends State<ShowFavoritePage> {
  late final AuthBloc _authBloc;
  late List<String> _idList;
  final _flagOrderByKey = GlobalKey<CheckWidgetState>(debugLabel: 'flag_Order');

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

  void _orderByName() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorites'),
        actions: [],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
              vertical: vspace_m, horizontal: hspace_s),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              FilterContainerWidget(
                  child: Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: vspace_l, horizontal: hspace_l),
                child: Row(
                  children: [
                    const Expanded(
                        flex: 1,
                        child: TextWidget(
                          "Order by Name",
                          textAlign: TextAlign.center,
                        )),
                    CheckWidget(
                      key: _flagOrderByKey,
                      //isChecked: _flagNoRealizadosKey.currentState!.value,
                      onTap: () {
                        _flagOrderByKey.currentState!.value =
                            !_flagOrderByKey.currentState!.value;
                        _orderByName();
                      },
                    ),
                  ],
                ),
              )),
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
                        } else {
                          return ShowIdListWidget(showIdList: _idList);
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
