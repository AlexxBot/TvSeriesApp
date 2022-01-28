import 'package:dartz/dartz.dart';
import 'package:tvseries_app/core/error/failures.dart';
import 'package:tvseries_app/features/show/domain/entities/show_filter.dart';
import 'package:tvseries_app/features/show/domain/entities/show_item.dart';
import 'package:tvseries_app/features/show/domain/repository/show_repository.dart';

abstract class UseCase {
  Future<Either<Failure, List<ShowItem>>> search(ShowFilter showFilter);
}

class ShowUseCase implements UseCase {
  final ShowRepository repository;
  ShowUseCase(this.repository);

  @override
  Future<Either<Failure, List<ShowItem>>> search(ShowFilter showFilter) async {
    return await repository.search(showFilter);
  }
}
