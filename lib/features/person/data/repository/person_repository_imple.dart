import 'package:dartz/dartz.dart';
import 'package:tvseries_app/core/error/exceptions.dart';
import 'package:tvseries_app/core/error/failures.dart';
import 'package:tvseries_app/core/network/network_info.dart';
import 'package:tvseries_app/features/person/data/datasources/person_remote_data.dart';
import 'package:tvseries_app/features/person/domain/entities/person.dart';
import 'package:tvseries_app/features/person/domain/entities/person_filter.dart';

import 'package:tvseries_app/features/person/domain/repository/person_repository.dart';

class PersonRepositoryImple implements PersonRepository {
  final PersonRemoteData remoteDataSource;
  final NetworkInfo networkInfo;
  //final NetWor

  PersonRepositoryImple({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<Person>>> search(PersonFilter filter) async {
    if (await networkInfo.isConnected) {
      try {
        final persons = await remoteDataSource.search(filter);
        return Right(persons);
      } on ApiResponseException catch (m) {
        return Left(ApiResponseFailure(message: m.message));
      } on TimeOutException {
        return Left(TimeOutFailure());
      } catch (ex) {
        return Left(ServerFailure(message: ex.toString()));
      }
    } else {
      return Left(ServerFailure());
    }
  }

  /* @override
  Future<Either<Failure, List<Episode>>> getEpisodes(String id) async {
    if (await networkInfo.isConnected) {
      try {
        //await sl<Headers>().validateToken();
        final episodes = await remoteDataSource.getEpisodes(id);
        return Right(episodes);
      } on ApiResponseException catch (m) {
        return Left(ApiResponseFailure(message: m.message));
      } on TimeOutException {
        return Left(TimeOutFailure());
      } catch (ex) {
        return Left(ServerFailure(message: ex.toString()));
      }
    } else {
      return Left(ServerFailure());
    }
  }
 */
  @override
  Future<Either<Failure, Person>> getPerson(String id) async {
    if (await networkInfo.isConnected) {
      try {
        final persons = await remoteDataSource.getPerson(id);
        return Right(persons);
      } on ApiResponseException catch (m) {
        return Left(ApiResponseFailure(message: m.message));
      } on TimeOutException {
        return Left(TimeOutFailure());
      } catch (ex) {
        return Left(ServerFailure(message: ex.toString()));
      }
    } else {
      return Left(ServerFailure());
    }
  }
}
