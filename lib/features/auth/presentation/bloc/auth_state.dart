part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {}

class LoadingState extends AuthState {}

class FavoritesRetrivedState extends AuthState {
  final List<String> idList;
  const FavoritesRetrivedState({required this.idList});
}

class SuccessfulState extends AuthState {
  final String message;
  const SuccessfulState({required this.message});
}

class ErrorState extends AuthState {
  final String message;
  const ErrorState({this.message = ''});
}
