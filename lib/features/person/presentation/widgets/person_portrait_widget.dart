import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tvseries_app/core/global/size_constants.dart';
import 'package:tvseries_app/core/global/theme_data.dart';
import 'package:tvseries_app/core/widgets/paragraph_widget.dart';
import 'package:tvseries_app/core/widgets/text_widget.dart';
import 'package:tvseries_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:tvseries_app/features/person/domain/entities/person.dart';
import 'package:tvseries_app/features/show/presentation/widgets/image_widget.dart';

class PersonPortraitWidget extends StatefulWidget {
  final Person person;
  const PersonPortraitWidget({Key? key, required this.person})
      : super(key: key);

  @override
  State<PersonPortraitWidget> createState() => _PersonPortraitWidgetState();
}

class _PersonPortraitWidgetState extends State<PersonPortraitWidget> {
  late AuthBloc _authBloc;

  late bool _isFavorite;

  @override
  void initState() {
    super.initState();
    _authBloc = BlocProvider.of<AuthBloc>(context);
    _isFavorite = false;
    _authBloc.add(ExistFavoriteEvent(id: widget.person.id.toString()));
  }

  void _addToFavorites() {
    if (_isFavorite) {
      _authBloc.add(DeleteFavoriteEvent(id: widget.person.id.toString()));
    } else {
      _authBloc.add(SaveFavoriteEvent(id: widget.person.id.toString()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return /* Container(
        padding: const EdgeInsets.symmetric(
            vertical: vspace_m, horizontal: hspace_m),
        //constraints: const BoxConstraints.expand(),
        width: double.infinity,
        child: Stack(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: PersonImageWidget(imageUrl: person.imageUrl),
            ),
            Align(
              alignment: Alignment.topRight,
              child: TextWidget(person.name),
            )
          ],
        )); */
        Container(
      decoration: BoxDecoration(
        image: widget.person.imageUrl != null
            ? DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(widget.person.imageUrl!),
                colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.5), BlendMode.dstATop),
              )
            : null,
      ),
      padding:
          const EdgeInsets.symmetric(vertical: vspace_m, horizontal: hspace_m),
      child: Column(
        children: [
          /* Container(
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
                        widget.person.genres[index],
                        fontSize: fontSize_s,
                        color: Colors.black,
                      )),
                );
              },
              itemCount: widget.person.genres.length,
            ),
          ), */
          Row(
            children: [
              /* ImageWidget(
                imageUrl: person.imageUrl,
                height: 200,
                width: 150,
              ), */
              Stack(
                children: [
                  ImageWidget(
                      imageUrl: widget.person.imageUrl,
                      height: 200,
                      width: 150),
                ],
              ),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    /* ParagraphWidget(
                      widget.person.summary,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: vspace_s, horizontal: hspace_s),
                      child: Row(
                        children: [
                          TextWidget('time: ${widget.person.scheduleTime}'),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: vspace_s, horizontal: hspace_s),
                            child: SingleChildScrollView(
                                child: Row(
                              children: widget.person.scheduleDays
                                  .map((e) => Chip(
                                          label: TextWidget(
                                        e,
                                        fontSize: fontSize_s,
                                        color: Colors.black,
                                      )))
                                  .toList(),
                            )),
                          )
                        ],
                      ),
                    ) */
                    /* Html(
                      data: person.summary,
                      style: {'p': Style(color: Colors.white)},
                    ) */
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
