import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tvseries_app/core/global/size_constants.dart';
import 'package:tvseries_app/core/global/theme_data.dart';
import 'package:tvseries_app/core/widgets/custom_page_route.dart';
import 'package:tvseries_app/core/widgets/text_widget.dart';
import 'package:tvseries_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:tvseries_app/features/person/domain/entities/person.dart';
import 'package:tvseries_app/features/show/presentation/widgets/image_widget.dart';

class PersonItemWidget extends StatefulWidget {
  final Person person;
  final bool favoriteInitialValue;
  const PersonItemWidget(
      {Key? key, required this.person, this.favoriteInitialValue = false})
      : super(key: key);

  @override
  State<PersonItemWidget> createState() => _PersonItemWidgetState();
}

class _PersonItemWidgetState extends State<PersonItemWidget> {
  late AuthBloc _authBloc;

  late bool _isFavorite;

  @override
  void initState() {
    super.initState();
    _authBloc = BlocProvider.of<AuthBloc>(context);
    _isFavorite = widget.favoriteInitialValue;
    _authBloc.add(ExistFavoriteEvent(id: widget.person.id.toString()));
  }

  /* void _goToDetail(BuildContext context) {
    Navigator.of(context)
        .push(CustomPageRoute(PersonDetailPage(person: widget.person)));
  } */

  void _addToFavorites() {
    if (_isFavorite) {
      _authBloc.add(DeleteFavoriteEvent(id: widget.person.id.toString()));
    } else {
      _authBloc.add(SaveFavoriteEvent(id: widget.person.id.toString()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        //_goToDetail(context);
      },
      child: FittedBox(
        child: Column(
          children: [
            Stack(
              children: [
                ImageWidget(
                    imageUrl: widget.person.imageUrl, height: 200, width: 150),
                Align(
                  alignment: Alignment.bottomRight,
                  child: BlocListener<AuthBloc, AuthState>(
                    listener: (context, state) {
                      if (state is FavoriteExistState) {
                        if (state.id == widget.person.id.toString()) {
                          _isFavorite = state.exist;
                        }
                      }
                      if (state is FavoriteSavedState) {
                        if (state.id == widget.person.id.toString()) {
                          if (state.saved) _isFavorite = true;
                          /* SnackWidget.personMessage(
                              context, 'Added to favorites'); */
                        }
                      }
                      if (state is FavoriteDeletedState) {
                        if (state.id == widget.person.id.toString()) {
                          if (state.deleted) _isFavorite = false;
                          /* SnackWidget.personMessage(
                              context, 'Deleted from favorites'); */
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
            //Image.network(person.imageUrl ?? ''),
            TextWidget(
              widget.person.name + ' ' + widget.person.id.toString(),
              fontSize: fontSize_l,
              color: textColor,
            ),
          ],
        ),
      ),
    );
  }
}
