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

class FavoriteExistState extends AuthState {
  final String id;
  final bool exist;

  const FavoriteExistState({required this.id, required this.exist});
}

class FavoriteSavedState extends AuthState {
  final String id;
  final bool saved;

  const FavoriteSavedState({required this.id, required this.saved});
}

class FavoriteDeletedState extends AuthState {
  final String id;
  final bool deleted;

  const FavoriteDeletedState({required this.id, required this.deleted});
}

/* class SuccessfulState extends AuthState {
  final String message;
  const SuccessfulState({required this.message});
} */

class ErrorState extends AuthState {
  final String message;
  const ErrorState({this.message = ''});
}

/* class LoggedInState extends AuthState {
  const LoggedInState();
} */

class PinRetrivedState extends AuthState {
  final String pinNumber;
  const PinRetrivedState({required this.pinNumber});
}

class PinSavedState extends AuthState {
  final bool saved;
  const PinSavedState({required this.saved});
}

class LoggedOutState extends AuthState {
  LoggedOutState();
}
