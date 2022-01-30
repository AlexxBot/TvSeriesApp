import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tvseries_app/core/global/size_constants.dart';
import 'package:tvseries_app/core/global/theme_data.dart';
import 'package:tvseries_app/core/widgets/custom_page_route.dart';
import 'package:tvseries_app/core/widgets/text_widget.dart';
import 'package:tvseries_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:tvseries_app/features/show/domain/entities/show_item.dart';
import 'package:tvseries_app/features/show/presentation/pages/show_detail_page.dart';
import 'package:tvseries_app/features/show/presentation/widgets/image_widget.dart';

class ShowItemWidget extends StatefulWidget {
  final ShowItem showItem;
  const ShowItemWidget({Key? key, required this.showItem}) : super(key: key);

  @override
  State<ShowItemWidget> createState() => _ShowItemWidgetState();
}

class _ShowItemWidgetState extends State<ShowItemWidget> {
  late AuthBloc _authBloc;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _authBloc = BlocProvider.of<AuthBloc>(context);
  }

  void _goToDetail(BuildContext context) {
    Navigator.of(context)
        .push(CustomPageRoute(ShowDetailPage(showItem: widget.showItem)));
  }

  void _addToFavorites() {
    _authBloc.add(SaveFavoriteEvent(id: widget.showItem.id.toString()));
  }

  @override
  Widget build(BuildContext context) {
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
                    imageUrl: widget.showItem.imageUrl,
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
              widget.showItem.name,
              fontSize: fontSize_l,
              color: textColor,
            ),
          ],
        ),
      ),
    );
  }
}
