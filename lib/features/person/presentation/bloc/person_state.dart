part of 'person_bloc.dart';

abstract class PersonState extends Equatable {
  const PersonState();

  @override
  List<Object> get props => [];
}

class PersonInitial extends PersonState {}

class LoadingState extends PersonState {}

class PersonsListedState extends PersonState {
  final List<Person> list;
  const PersonsListedState({required this.list});
}

class RetrivedState extends PersonState {
  final Person person;
  const RetrivedState({required this.person});
}

/* class EpisodesListedState extends PersonState {
  final List<Episode> list;
  const EpisodesListedState({required this.list});
} */

class ErrorState extends PersonState {
  final String message;
  const ErrorState({this.message = ''});
}
