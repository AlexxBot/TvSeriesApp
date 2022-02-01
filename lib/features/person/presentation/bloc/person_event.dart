part of 'person_bloc.dart';

abstract class PersonEvent extends Equatable {
  const PersonEvent();

  @override
  List<Object> get props => [];
}

class SearchPersonsEvent extends PersonEvent {
  final PersonFilter filter;
  const SearchPersonsEvent({required this.filter});
}

class GetPersonEvent extends PersonEvent {
  final String id;
  const GetPersonEvent({required this.id});
}

class GetShowListEvent extends PersonEvent {
  final String id;
  const GetShowListEvent({required this.id});
}

class GetEpisodeEvent extends PersonEvent {
  final String id;
  final String season;
  final String episode;

  const GetEpisodeEvent(
      {required this.id, required this.season, required this.episode});
}
