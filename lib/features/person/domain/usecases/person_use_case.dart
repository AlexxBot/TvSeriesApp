import 'package:dartz/dartz.dart';
import 'package:tvseries_app/core/error/failures.dart';
import 'package:tvseries_app/features/person/domain/entities/person.dart';
import 'package:tvseries_app/features/person/domain/entities/person_filter.dart';
import 'package:tvseries_app/features/person/domain/repository/person_repository.dart';
import 'package:tvseries_app/features/show/domain/entities/show_item.dart';

abstract class UseCase {
  Future<Either<Failure, List<Person>>> search(PersonFilter personFilter);

  Future<Either<Failure, Person>> getPerson(String id);

  Future<Either<Failure, List<ShowItem>>> getShows(String id);
}

class PersonUseCase implements UseCase {
  final PersonRepository repository;
  PersonUseCase(this.repository);

  @override
  Future<Either<Failure, List<Person>>> search(
      PersonFilter personFilter) async {
    return await repository.search(personFilter);
  }

  @override
  Future<Either<Failure, List<ShowItem>>> getShows(String id) async {
    return await repository.getShows(id);
  }

  @override
  Future<Either<Failure, Person>> getPerson(String id) async {
    return await repository.getPerson(id);
  }
}
