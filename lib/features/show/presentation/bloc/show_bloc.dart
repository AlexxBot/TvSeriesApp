import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:tvseries_app/core/error/failures.dart';
import 'package:tvseries_app/features/show/domain/entities/show_filter.dart';
import 'package:tvseries_app/features/show/domain/entities/show_item.dart';
import 'package:tvseries_app/features/show/domain/usecases/show_use_case.dart';

part 'show_event.dart';
part 'show_state.dart';

class ShowBloc extends Bloc<ShowEvent, ShowState> {
  final ShowUseCase showUseCase;
  ShowBloc({required this.showUseCase}) : super(ShowInitial());

  @override
  Stream<ShowState> mapEventToState(
    ShowEvent event,
  ) async* {
    if (event is SearchEvent) {
      yield LoadingState();
      final failureOrSearched = await showUseCase.search(event.filter);
      yield* _eitherListedOrErrorState(failureOrSearched);
    }
  }

  Stream<ShowState> _eitherListedOrErrorState(
      Either<Failure, List<ShowItem>> failureOrListed) async* {
    yield failureOrListed.fold(
        (failure) => ErrorState(message: failure.message),
        (showList) => ListedState(list: showList));
  }
}
