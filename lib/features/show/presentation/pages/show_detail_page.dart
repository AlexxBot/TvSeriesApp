import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tvseries_app/core/global/size_constants.dart';
import 'package:tvseries_app/core/widgets/snack_widget.dart';
import 'package:tvseries_app/core/widgets/text_widget.dart';
import 'package:tvseries_app/features/show/domain/entities/episode.dart';
import 'package:tvseries_app/features/show/domain/entities/show_item.dart';
import 'package:tvseries_app/features/show/presentation/bloc/show_bloc.dart';
import 'package:tvseries_app/features/show/presentation/widgets/episode_list_widget.dart';
import 'package:tvseries_app/features/show/presentation/widgets/show_portrait_widget.dart';
import 'package:tvseries_app/features/show/presentation/widgets/image_widget.dart';
import 'package:tvseries_app/features/show/presentation/widgets/show_list_widget.dart';

class ShowDetailPage extends StatefulWidget {
  final ShowItem showItem;
  const ShowDetailPage({Key? key, required this.showItem}) : super(key: key);

  @override
  _ShowDetailPageState createState() => _ShowDetailPageState();
}

class _ShowDetailPageState extends State<ShowDetailPage> {
  late final ShowBloc _showBloc;
  late List<Episode> _episodeList;

  //late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _showBloc = BlocProvider.of<ShowBloc>(context);
    _episodeList = [];
    _showBloc.add(GetEpisodeListEvent(id: widget.showItem.id.toString()));
    //_tabController = new TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.showItem.name),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
              vertical: vspace_m, horizontal: hspace_s),
          child: Column(
            children: [
              ShowPortraitWidget(showItem: widget.showItem),
              Expanded(
                  child: BlocListener<ShowBloc, ShowState>(
                      bloc: _showBloc,
                      listener: (context, state) {
                        if (state is EpisodesListedState) {
                          _episodeList = state.list;
                        }
                      },
                      child: BlocBuilder<ShowBloc, ShowState>(
                        bloc: _showBloc,
                        builder: (context, state) {
                          if (state is LoadingState) {
                            return const Center(
                                child: CircularProgressIndicator());
                          } else {
                            return EpisodeListWidget(episodeList: _episodeList);
                          }
                        },
                      )))
            ],
          ),
        ),
      ),
    );
  }
}
