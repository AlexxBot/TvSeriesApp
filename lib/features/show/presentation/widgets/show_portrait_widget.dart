import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
//import 'package:flutter_html/flutter_html.dart';
import 'package:tvseries_app/core/global/size_constants.dart';
import 'package:tvseries_app/core/global/theme_data.dart';
import 'package:tvseries_app/core/widgets/paragraph_widget.dart';
import 'package:tvseries_app/core/widgets/text_widget.dart';
import 'package:tvseries_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:tvseries_app/features/show/domain/entities/show_item.dart';
import 'package:tvseries_app/core/widgets/image_widget.dart';

class ShowPortraitWidget extends StatefulWidget {
  final ShowItem showItem;
  const ShowPortraitWidget({Key? key, required this.showItem})
      : super(key: key);

  @override
  State<ShowPortraitWidget> createState() => _ShowPortraitWidgetState();
}

class _ShowPortraitWidgetState extends State<ShowPortraitWidget> {
  late AuthBloc _authBloc;

  late bool _isFavorite;

  @override
  void initState() {
    super.initState();
    _authBloc = BlocProvider.of<AuthBloc>(context);
    _isFavorite = false;
    _authBloc.add(ExistFavoriteEvent(id: widget.showItem.id.toString()));
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
    return Container(
      decoration: BoxDecoration(
        image: widget.showItem.imageUrl != null
            ? DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(widget.showItem.imageUrl!),
                colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.4), BlendMode.dstATop),
              )
            : null,
      ),
      padding:
          const EdgeInsets.symmetric(vertical: vspace_m, horizontal: hspace_m),
      child: Column(
        children: [
          SizedBox(
            height: 40,
            width: double.infinity,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(vspace_s),
                  child: Chip(
                      padding: const EdgeInsets.all(0),
                      elevation: 5,
                      label: TextWidget(
                        widget.showItem.genres[index],
                        fontSize: fontSize_s,
                        color: Colors.black,
                      )),
                );
              },
              itemCount: widget.showItem.genres.length,
            ),
          ),
          Row(
            children: [
              Stack(
                children: [
                  ImageWidget(
                      imageUrl: widget.showItem.imageUrl,
                      height: 200,
                      width: 150),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: BlocListener<AuthBloc, AuthState>(
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
                              onPressed: _addToFavorites,
                              icon: Icon(
                                Icons.favorite,
                                color:
                                    _isFavorite ? errorColor : filterBackground,
                              ));
                        },
                      ),
                    ),
                  )
                ],
              ),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ParagraphWidget(
                      widget.showItem.summary,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: hspace_m),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          TextWidget('time: ${widget.showItem.scheduleTime}'),
                          Expanded(
                              child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            padding: const EdgeInsets.only(left: hspace_m),
                            child: Row(
                              children: widget.showItem.scheduleDays
                                  .map((e) => Padding(
                                      padding:
                                          const EdgeInsets.only(left: hspace_m),
                                      child: Chip(
                                          label: TextWidget(
                                        e,
                                        fontSize: fontSize_s,
                                        color: Colors.black,
                                      ))))
                                  .toList(),
                            ),
                          ))
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
