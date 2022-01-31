part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class GetFavoritesEvent extends AuthEvent {
  const GetFavoritesEvent();
}

class SaveFavoriteEvent extends AuthEvent {
  final String id;
  const SaveFavoriteEvent({required this.id});
}

class DeleteFavoriteEvent extends AuthEvent {
  final String id;
  const DeleteFavoriteEvent({required this.id});
}

class ExistFavoriteEvent extends AuthEvent {
  final String id;
  const ExistFavoriteEvent({required this.id});
}

/* class LoginEvent extends AuthEvent {
  final String pin;
  const LoginEvent({required this.pin});
} */

class GetPinEvent extends AuthEvent {
  const GetPinEvent();
}

class SetPinEvent extends AuthEvent {
  final String pinNumber;
  const SetPinEvent({required this.pinNumber});
}

class LogoutEvent extends AuthEvent {
  const LogoutEvent();
}



/* class GetEpisodeEvent extends ShowEvent {
  final String id;
  final String season;
  final String episode;

  const GetEpisodeEvent(
      {required this.id, required this.season, required this.episode});
} */
