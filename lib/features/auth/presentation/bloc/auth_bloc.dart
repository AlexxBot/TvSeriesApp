import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:tvseries_app/core/error/failures.dart';
import 'package:tvseries_app/features/auth/domain/usecases/auth_use_case.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthUseCase authUseCase;
  AuthBloc({required this.authUseCase}) : super(AuthInitial());

  @override
  Stream<AuthState> mapEventToState(
    AuthEvent event,
  ) async* {
    if (event is GetFavoritesEvent) {
      yield LoadingState();
      final failureOrSearched = await authUseCase.getFavorites();
      yield* _eitherRetrivedOrErrorState(failureOrSearched);
    }

    if (event is SaveFavoriteEvent) {
      yield LoadingState();
      final failureOrEpisodesGetted = await authUseCase.saveFavorite(event.id);
      yield* _eitherSavedOrErrorState(failureOrEpisodesGetted);
    }

    if (event is DeleteFavoriteEvent) {
      yield LoadingState();
      final failureOrEpisodesGetted =
          await authUseCase.deleteFavorite(event.id);
      yield* _eitherDeletedOrErrorState(failureOrEpisodesGetted);
    }
  }

  Stream<AuthState> _eitherRetrivedOrErrorState(
      Either<Failure, List<String>> failureOrListed) async* {
    yield failureOrListed.fold(
        (failure) => ErrorState(message: failure.message),
        (favoriteList) => FavoritesRetrivedState(idList: favoriteList));
  }

  Stream<AuthState> _eitherSavedOrErrorState(
      Either<Failure, bool> failureOrListed) async* {
    yield* failureOrListed.fold((failure) async* {
      yield ErrorState(message: failure.message);
    }, (response) async* {
      if (response) {
        yield const SuccessfulState(message: 'Added to Favorites');
      } else {
        yield const ErrorState(message: 'Error adding to Favorites');
      }
    });
  }

  Stream<AuthState> _eitherDeletedOrErrorState(
      Either<Failure, bool> failureOrListed) async* {
    yield* failureOrListed.fold((failure) async* {
      yield ErrorState(message: failure.message);
    }, (response) async* {
      if (response) {
        yield const SuccessfulState(message: 'Deleted from Favorites');
      } else {
        yield const ErrorState(message: 'Error deleting from Favorites');
      }
    });
  }
}
