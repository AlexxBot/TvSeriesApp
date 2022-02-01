import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tvseries_app/features/show/domain/entities/show_item.dart';
import 'package:tvseries_app/features/show/presentation/bloc/show_bloc.dart';
import 'package:tvseries_app/features/show/presentation/widgets/show_item_widget.dart';

class ShowIdItemWidget extends StatefulWidget {
  final String showId;
  const ShowIdItemWidget({Key? key, required this.showId}) : super(key: key);

  @override
  State<ShowIdItemWidget> createState() => _ShowIdItemWidgetState();
}

class _ShowIdItemWidgetState extends State<ShowIdItemWidget> {
  late final ShowBloc _showBloc;
  late ShowItem _showItem;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _showItem = ShowItem(id: 0, name: '');
    _showBloc = BlocProvider.of<ShowBloc>(context);
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
          if (_showItem.id != 0) {
            return ShowItemWidget(
              showItem: _showItem,
              favoriteInitialValue: true,
            );
          } else {
            return const SizedBox(
                height: 200,
                width: 150,
                child: Center(child: CircularProgressIndicator()));
          }
        },
      ),
    );
  }
}
