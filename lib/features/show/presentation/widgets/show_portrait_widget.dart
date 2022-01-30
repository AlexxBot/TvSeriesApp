import 'package:flutter/material.dart';
import 'package:tvseries_app/core/global/size_constants.dart';
import 'package:tvseries_app/core/widgets/paragraph_widget.dart';
import 'package:tvseries_app/core/widgets/text_widget.dart';
import 'package:tvseries_app/features/show/domain/entities/show_item.dart';
import 'package:tvseries_app/features/show/presentation/widgets/image_widget.dart';

class ShowPortraitWidget extends StatelessWidget {
  final ShowItem showItem;
  const ShowPortraitWidget({Key? key, required this.showItem})
      : super(key: key);

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
              child: ShowImageWidget(imageUrl: showItem.imageUrl),
            ),
            Align(
              alignment: Alignment.topRight,
              child: TextWidget(showItem.name),
            )
          ],
        )); */
        Container(
      decoration: BoxDecoration(
        image: showItem.imageUrl != null
            ? DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(showItem.imageUrl!),
                colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.5), BlendMode.dstATop),
              )
            : null,
      ),
      padding:
          const EdgeInsets.symmetric(vertical: vspace_m, horizontal: hspace_m),
      child: Column(
        children: [
          Container(
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
                        showItem.genres[index],
                        fontSize: fontSize_s,
                        color: Colors.black,
                      )),
                );
              },
              itemCount: showItem.genres.length,
            ),
          ),
          Row(
            children: [
              ImageWidget(
                imageUrl: showItem.imageUrl,
                height: 200,
                width: 150,
              ),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ParagraphWidget(
                      showItem.summary,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: vspace_s, horizontal: hspace_s),
                      child: Row(
                        children: [
                          TextWidget('time: ${showItem.scheduleTime}'),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: vspace_s, horizontal: hspace_s),
                            child: SingleChildScrollView(
                                child: Row(
                              children: showItem.scheduleDays
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
                    )
                    /* Html(
                      data: showItem.summary,
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
