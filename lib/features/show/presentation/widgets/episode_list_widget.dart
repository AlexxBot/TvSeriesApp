import 'package:flutter/material.dart';
import 'package:tvseries_app/core/global/size_constants.dart';
import 'package:tvseries_app/core/global/theme_data.dart';
import 'package:tvseries_app/core/widgets/paragraph_widget.dart';
import 'package:tvseries_app/core/widgets/text_widget.dart';
import 'package:tvseries_app/features/show/domain/entities/episode.dart';
import 'package:tvseries_app/core/widgets/image_widget.dart';

class EpisodeListWidget extends StatefulWidget {
  final List<Episode> episodeList;
  const EpisodeListWidget({Key? key, required this.episodeList})
      : super(key: key);

  @override
  State<EpisodeListWidget> createState() => _EpisodeListWidgetState();
}

class _EpisodeListWidgetState extends State<EpisodeListWidget>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  List<Widget> _seasons = [];
  late TabController _tabController;
  late final _seasonsCount;

  List<Widget> _tabsBar = [];
  List<Widget> _tabsBarView = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _seasonsCount = _getTotalSeasons();
    _tabController = TabController(length: _seasonsCount, vsync: this);
    setState(() {
      _fillSeasons();
    });
  }

  int _getTotalSeasons() {
    int max = 0;
    for (int i = 0; i < widget.episodeList.length; i++) {
      if (widget.episodeList[i].season > max) {
        max = widget.episodeList[i].season;
      }
    }
    return max;
  }

  _fillSeasons() {
    for (int i = 0; i < _seasonsCount; i++) {
      _tabsBar.add(
        Padding(
          padding: const EdgeInsets.symmetric(
              vertical: vspace_s, horizontal: hspace_s),
          child: TextWidget(
            'Season ${i + 1}',
            fontSize: fontSize_l,
          ),
        ),
      );
      _tabsBarView.add(
        Container(
          decoration: BoxDecoration(
              color: filterBackground.withOpacity(0.2),
              borderRadius:
                  const BorderRadius.all(Radius.circular(borderRadiusInput))),
          child: Scrollbar(
            child: SingleChildScrollView(
              child: Wrap(
                children: [],
              ),
            ),
          ),
        ),
      );
    }
    for (int i = 0; i < widget.episodeList.length; i++) {
      ((((_tabsBarView[widget.episodeList[i].season - 1] as Container).child
                      as Scrollbar)
                  .child as SingleChildScrollView)
              .child as Wrap)
          .children
          .add(ExpansionTile(
            collapsedIconColor: Colors.white,
            maintainState: true,
            childrenPadding: const EdgeInsets.only(left: hspace_xxl * 2),
            title: ListTile(
                contentPadding: const EdgeInsets.all(0),
                minVerticalPadding: 0,
                minLeadingWidth: 0,
                leading: TextWidget(widget.episodeList[i].number.toString()),
                title: TextWidget(widget.episodeList[i].name)),
            children: [
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  ImageWidget(
                    imageUrl: widget.episodeList[i].imageUrl,
                    height: 100,
                    width: 75,
                    showNull: false,
                    //scale: 0.5,
                  ),
                  Expanded(
                      child: ParagraphWidget(widget.episodeList[i].summary))
                  /* Html(
                    data: widget.episodeList[i].summary,
                    style: {'p': Style(color: Colors.white)},
                  ) */
                ],
              ),
            ],
          ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding:
              const EdgeInsets.symmetric(vertical: vspace_m, horizontal: 0),
          child: TabBar(
              isScrollable: true,
              controller: _tabController,
              unselectedLabelColor: Colors.black,
              indicatorWeight: 3.0,

              //indicatorColor: Colors.red,
              //labelColor: Colors.red,
              tabs: _tabsBar),
        ),
        Expanded(
          child: _seasonsCount == 0
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : TabBarView(
                  children: _tabsBarView,
                  controller: _tabController,
                ),
        ),
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}
