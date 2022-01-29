part of 'show_bloc.dart';

abstract class ShowState extends Equatable {
  const ShowState();

  @override
  List<Object> get props => [];
}

class ShowInitial extends ShowState {}

class LoadingState extends ShowState {}

class ShowsListedState extends ShowState {
  final List<ShowItem> list;
  const ShowsListedState({required this.list});
}

class EpisodesListedState extends ShowState {
  final List<Episode> list;
  const EpisodesListedState({required this.list});
}

class ErrorState extends ShowState {
  final String message;
  const ErrorState({this.message = ''});
}
