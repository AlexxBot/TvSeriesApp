import 'package:dartz/dartz.dart';
import 'package:tvseries_app/core/error/failures.dart';
import 'package:tvseries_app/features/person/domain/entities/person.dart';
import 'package:tvseries_app/features/person/domain/entities/person_filter.dart';
import 'package:tvseries_app/features/show/domain/entities/episode.dart';

abstract class PersonRepository {
  Future<Either<Failure, List<Person>>> search(PersonFilter showFilter);
  Future<Either<Failure, Person>> getPerson(String id);
  //Future<Either<Failure, List<Episode>>> getEpisodes(String id);
}
