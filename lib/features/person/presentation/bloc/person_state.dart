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

class ShowsListedState extends PersonState {
  final List<ShowItem> list;
  const ShowsListedState({required this.list});
}

class ErrorState extends PersonState {
  final String message;
  const ErrorState({this.message = ''});
}
