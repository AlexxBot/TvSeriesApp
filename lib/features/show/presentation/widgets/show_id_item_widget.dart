import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tvseries_app/core/global/size_constants.dart';
import 'package:tvseries_app/core/global/theme_data.dart';
import 'package:tvseries_app/core/widgets/custom_page_route.dart';
import 'package:tvseries_app/core/widgets/text_widget.dart';
import 'package:tvseries_app/features/auth/presentation/bloc/auth_bloc.dart'
    as authbloc;
import 'package:tvseries_app/features/show/domain/entities/show_item.dart';
import 'package:tvseries_app/features/show/presentation/bloc/show_bloc.dart';
import 'package:tvseries_app/features/show/presentation/pages/show_detail_page.dart';
import 'package:tvseries_app/features/show/presentation/widgets/image_widget.dart';
import 'package:tvseries_app/features/show/presentation/widgets/show_item_widget.dart';

class ShowIdItemWidget extends StatefulWidget {
  final String showId;
  const ShowIdItemWidget({Key? key, required this.showId}) : super(key: key);

  @override
  State<ShowIdItemWidget> createState() => _ShowIdItemWidgetState();
}

class _ShowIdItemWidgetState extends State<ShowIdItemWidget>
    with
        AutomaticKeepAliveClientMixin,
        TickerProviderStateMixin,
        SingleTickerProviderStateMixin {
  late final ShowBloc _showBloc;
  late final authbloc.AuthBloc _authBloc;
  late ShowItem _showItem;

  late bool _isFavorite;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _isFavorite = false;
    _showItem = ShowItem(id: 0, name: '');
    _showBloc = BlocProvider.of<ShowBloc>(context);
    _authBloc = BlocProvider.of<authbloc.AuthBloc>(context);
    _showBloc.add(GetShowEvent(id: widget.showId));
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ShowBloc, ShowState>(
      listener: (context, state) {
        if (state is RetrivedState) {
          if (state.show.id.toString() == widget.showId) {
            _showItem = state.show;
          }
        }
      },
      child: BlocBuilder<ShowBloc, ShowState>(
        builder: (context, state) {
          if (/* state is RetrivedState &&  */ _showItem.id != 0) {
            return ShowItemWidget(
              showItem: _showItem,
              favoriteInitialValue: true,
            );
          } else if (state is authbloc.ErrorState) {
            return Container(
              height: 200,
              width: 150,
              child: const Center(child: TextWidget('Api exception')),
            );
          }
          if (/* state is RetrivedState &&  */ _showItem.id != 0) {
            return ShowItemWidget(
              showItem: _showItem,
              favoriteInitialValue: true,
            );
          } else {
            return Container(
              height: 200,
              width: 150,
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        },
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
