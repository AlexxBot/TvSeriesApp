part of 'show_bloc.dart';

abstract class ShowEvent extends Equatable {
  const ShowEvent();

  @override
  List<Object> get props => [];
}

class SearchShowsEvent extends ShowEvent {
  final ShowFilter filter;
  const SearchShowsEvent({required this.filter});
}

class GetEpisodeListEvent extends ShowEvent {
  final String id;
  const GetEpisodeListEvent({required this.id});
}

class GetEpisodeEvent extends ShowEvent {
  final String id;
  final String season;
  final String episode;

  const GetEpisodeEvent(
      {required this.id, required this.season, required this.episode});
}
