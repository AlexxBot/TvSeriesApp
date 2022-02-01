import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tvseries_app/core/global/size_constants.dart';
import 'package:tvseries_app/core/global/theme_data.dart';
import 'package:tvseries_app/core/widgets/custom_page_route.dart';
import 'package:tvseries_app/core/widgets/snack_widget.dart';
import 'package:tvseries_app/core/widgets/text_widget.dart';
import 'package:tvseries_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:tvseries_app/features/show/domain/entities/show_item.dart';
import 'package:tvseries_app/features/show/presentation/pages/show_detail_page.dart';
import 'package:tvseries_app/core/widgets/image_widget.dart';

class ShowItemWidget extends StatefulWidget {
  final ShowItem showItem;
  final bool favoriteInitialValue;
  const ShowItemWidget(
      {Key? key, required this.showItem, this.favoriteInitialValue = false})
      : super(key: key);

  @override
  State<ShowItemWidget> createState() => _ShowItemWidgetState();
}

class _ShowItemWidgetState extends State<ShowItemWidget> {
  late AuthBloc _authBloc;

  late bool _isFavorite;

  @override
  void initState() {
    super.initState();
    _authBloc = BlocProvider.of<AuthBloc>(context);
    _isFavorite = widget.favoriteInitialValue;
    _authBloc.add(ExistFavoriteEvent(id: widget.showItem.id.toString()));
  }

  void _goToDetail(BuildContext context) {
    Navigator.of(context)
        .push(CustomPageRoute(ShowDetailPage(showItem: widget.showItem)));
  }

  void _addToFavorites() {
    if (_isFavorite) {
      _authBloc.add(DeleteFavoriteEvent(id: widget.showItem.id.toString()));
    } else {
      _authBloc.add(SaveFavoriteEvent(id: widget.showItem.id.toString()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        _goToDetail(context);
      },
      child: Column(
        /* mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center, */
        children: [
          Stack(
            alignment: Alignment.topLeft,
            children: [
              ImageWidget(
                  imageUrl: widget.showItem.imageUrl, height: 200, width: 150),
              BlocListener<AuthBloc, AuthState>(
                listener: (context, state) {
                  if (state is FavoriteExistState) {
                    if (state.id == widget.showItem.id.toString()) {
                      _isFavorite = state.exist;
                    }
                  }
                  if (state is FavoriteSavedState) {
                    if (state.id == widget.showItem.id.toString()) {
                      if (state.saved) _isFavorite = true;
                    }
                  }
                  if (state is FavoriteDeletedState) {
                    if (state.id == widget.showItem.id.toString()) {
                      if (state.deleted) _isFavorite = false;
                    }
                  }
                },
                child: BlocBuilder<AuthBloc, AuthState>(
                  builder: (context, state) {
                    return IconButton(
                        iconSize: 30,
                        onPressed: _addToFavorites,
                        icon: Icon(
                          Icons.favorite,
                          color: _isFavorite ? errorColor : filterBackground,
                        ));
                  },
                ),
              ),
            ],
          ),
          const SizedBox(
            height: vspace_s,
          ),
          TextWidget(
            widget.showItem.name,
            fontSize: fontSize_m,
            color: textColor,
          ),
        ],
      ),
    );
  }
}
