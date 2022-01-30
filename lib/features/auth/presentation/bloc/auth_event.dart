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

/* class GetEpisodeEvent extends ShowEvent {
  final String id;
  final String season;
  final String episode;

  const GetEpisodeEvent(
      {required this.id, required this.season, required this.episode});
} */
