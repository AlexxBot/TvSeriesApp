import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tvseries_app/core/global/size_constants.dart';
import 'package:tvseries_app/core/global/theme_data.dart';
import 'package:tvseries_app/core/widgets/custom_page_route.dart';
import 'package:tvseries_app/core/widgets/text_widget.dart';
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

  void _goToDetail(BuildContext context) {
    Navigator.of(context)
        .push(CustomPageRoute(ShowDetailPage(showItem: _showItem)));
  }

  void _addToFavorites() {}

  @override
  Widget build(BuildContext context) {
    return BlocListener<ShowBloc, ShowState>(
      listener: (context, state) {
        if (state is RetrivedState) {
          if (state.show.id.toString() == widget.showId) _showItem = state.show;
        }
      },
      child: BlocBuilder<ShowBloc, ShowState>(
        builder: (context, state) {
          if (state is LoadingState) {
            return Container(
              height: 200,
              width: 150,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else
            return InkWell(
              onTap: () {
                _goToDetail(context);
              },
              child: FittedBox(
                child: Column(
                  children: [
                    Stack(
                      children: [
                        ImageWidget(
                            imageUrl: _showItem.imageUrl,
                            height: 200,
                            width: 150),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: IconButton(
                              onPressed: _addToFavorites,
                              icon: const Icon(
                                Icons.favorite,
                                color: Colors.white,
                              )),
                        )
                      ],
                    ),
                    //Image.network(showItem.imageUrl ?? ''),
                    TextWidget(
                      _showItem.name,
                      fontSize: fontSize_l,
                      color: textColor,
                    ),
                  ],
                ),
              ),
            );
        },
      ),
    );
  }
}
