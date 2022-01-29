import 'package:flutter/material.dart';
import 'package:tvseries_app/core/widgets/text_widget.dart';
import 'package:tvseries_app/features/show/domain/entities/episode.dart';

class EpisodeListWidget extends StatefulWidget {
  final List<Episode> episodeList;
  const EpisodeListWidget({Key? key, required this.episodeList})
      : super(key: key);

  @override
  State<EpisodeListWidget> createState() => _EpisodeListWidgetState();
}

class _EpisodeListWidgetState extends State<EpisodeListWidget> {
  List<Widget> _seasons = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      _fillSeasons();
    });
  }

  _fillSeasons() {
    for (int i = 0; i < widget.episodeList.length; i++) {
      if (widget.episodeList[i].season > _seasons.length) {
        _seasons.add(ExpansionTile(
          children: [],
          title: TextWidget('Season ${widget.episodeList[i].season}'),
        ));
      }
      (_seasons[widget.episodeList[i].season - 1] as ExpansionTile)
          .children
          .add(ExpansionTile(
            title: TextWidget(widget.episodeList[i].name),
            children: [TextWidget(widget.episodeList[i].summary)],
          ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
        child: /* ListView.builder(
            itemCount: widget.episodeList.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(widget.episodeList[index].name),
              );
            })); */
            ListView(
      children: _seasons,
    ));
  }
}
