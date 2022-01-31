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
    if (event is GetPinEvent) {
      yield LoadingState();
      final failureOrGetted = await authUseCase.getPin();
      yield* failureOrGetted.fold((failure) async* {
        yield ErrorState(message: failure.message);
      }, (pin) async* {
        yield PinRetrivedState(pinNumber: pin);
      });
    }

    if (event is SetPinEvent) {
      yield LoadingState();
      final failureOrGetted = await authUseCase.setPin(event.pinNumber);
      yield* failureOrGetted.fold((failure) async* {
        yield ErrorState(message: failure.message);
      }, (saved) async* {
        yield PinSavedState(saved: saved);
      });
    }

    if (event is GetFavoritesEvent) {
      yield LoadingState();
      final failureOrGetted = await authUseCase.getFavorites();
      yield* _eitherRetrivedOrErrorState(failureOrGetted);
    }

    if (event is SaveFavoriteEvent) {
      yield LoadingState();
      final failureOrEpisodeSaved = await authUseCase.saveFavorite(event.id);
      //yield* _eitherSavedOrErrorState(failureOrEpisodeSaved);
      yield* failureOrEpisodeSaved.fold((failure) async* {
        yield ErrorState(message: failure.message);
      }, (response) async* {
        if (response) {
          yield FavoriteSavedState(id: event.id, saved: response);
        } else {
          yield const ErrorState(message: 'Error adding to Favorites');
        }
      });
    }

    if (event is DeleteFavoriteEvent) {
      yield LoadingState();
      final failureOrEpisodeDeleted =
          await authUseCase.deleteFavorite(event.id);
      //yield* _eitherDeletedOrErrorState(failureOrEpisodeDeleted);
      yield* failureOrEpisodeDeleted.fold((failure) async* {
        yield ErrorState(message: failure.message);
      }, (response) async* {
        if (response) {
          yield FavoriteDeletedState(id: event.id, deleted: response);
        } else {
          yield const ErrorState(message: 'Error deleting from Favorites');
        }
      });
    }

    if (event is ExistFavoriteEvent) {
      yield LoadingState();
      final failureOrEpisodesExist = await authUseCase.existFavorite(event.id);
      //yield* _eitherExistOrErrorState(failureOrEpisodesExist);
      yield* failureOrEpisodesExist.fold((failure) async* {
        yield ErrorState(message: failure.message);
      }, (response) async* {
        yield FavoriteExistState(id: event.id, exist: response);
      });
    }

    if (event is LogoutEvent) {
      yield LoadingState();
      yield LoggedOutState();
    }
  }

  Stream<AuthState> _eitherRetrivedOrErrorState(
      Either<Failure, List<String>> failureOrListed) async* {
    yield failureOrListed.fold(
        (failure) => ErrorState(message: failure.message),
        (favoriteList) => FavoritesRetrivedState(idList: favoriteList));
  }
}
