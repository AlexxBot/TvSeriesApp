part of 'show_bloc.dart';

abstract class ShowEvent extends Equatable {
  const ShowEvent();

  @override
  List<Object> get props => [];
}

class SearchEvent extends ShowEvent {
  final ShowFilter filter;
  const SearchEvent({required this.filter});
}
