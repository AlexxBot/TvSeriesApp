part of 'show_bloc.dart';

abstract class ShowState extends Equatable {
  const ShowState();

  @override
  List<Object> get props => [];
}

class ShowInitial extends ShowState {}

class LoadingState extends ShowState {}

class ListedState extends ShowState {
  final List<ShowItem> list;
  const ListedState({required this.list});
}

class ErrorState extends ShowState {
  final String message;
  const ErrorState({this.message = ''});
}
