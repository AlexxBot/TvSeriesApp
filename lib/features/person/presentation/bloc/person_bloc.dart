import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:tvseries_app/core/error/failures.dart';
import 'package:tvseries_app/features/person/domain/entities/person.dart';
import 'package:tvseries_app/features/person/domain/entities/person_filter.dart';
import 'package:tvseries_app/features/person/domain/usecases/person_use_case.dart';
import 'package:tvseries_app/features/show/domain/entities/show_item.dart';

part 'person_event.dart';
part 'person_state.dart';

class PersonBloc extends Bloc<PersonEvent, PersonState> {
  final PersonUseCase personUseCase;
  PersonBloc({required this.personUseCase}) : super(PersonInitial());

  @override
  Stream<PersonState> mapEventToState(
    PersonEvent event,
  ) async* {
    if (event is SearchPersonsEvent) {
      yield LoadingState();
      final failureOrSearched = await personUseCase.search(event.filter);
      yield* _eitherListedOrErrorState(failureOrSearched);
    }

    if (event is GetShowListEvent) {
      yield LoadingState();
      final failureOrEpisodesGetted = await personUseCase.getShows(event.id);
      yield* _eitherShowsRetrivedOrErrorState(failureOrEpisodesGetted);
    }

    if (event is GetPersonEvent) {
      yield LoadingState();
      final failureOrEpisodesGetted = await personUseCase.getPerson(event.id);
      yield* _eitherRetrivedOrErrorState(failureOrEpisodesGetted);
    }
  }

  Stream<PersonState> _eitherListedOrErrorState(
      Either<Failure, List<Person>> failureOrListed) async* {
    yield failureOrListed.fold(
        (failure) => ErrorState(message: failure.message),
        (personList) => PersonsListedState(list: personList));
  }

  Stream<PersonState> _eitherShowsRetrivedOrErrorState(
      Either<Failure, List<ShowItem>> failureOrListed) async* {
    yield failureOrListed.fold(
        (failure) => ErrorState(message: failure.message),
        (episodeList) => ShowsListedState(list: episodeList));
  }

  Stream<PersonState> _eitherRetrivedOrErrorState(
      Either<Failure, Person> failureOrListed) async* {
    yield failureOrListed.fold(
        (failure) => ErrorState(message: failure.message),
        (person) => RetrivedState(person: person));
  }
}
