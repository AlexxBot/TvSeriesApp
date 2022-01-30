import 'package:dartz/dartz.dart';
import 'package:tvseries_app/core/error/exceptions.dart';
import 'package:tvseries_app/core/error/failures.dart';
import 'package:tvseries_app/features/auth/data/datasources/auth_local_data.dart';
import 'package:tvseries_app/features/auth/domain/repository/auth_repository.dart';

class AuthRepositoryImple implements AuthRepository {
  final AuthLocalData localDataSource;
  //final NetWor

  AuthRepositoryImple({
    required this.localDataSource,
  });

  @override
  Future<Either<Failure, List<String>>> getFavorites() async {
    try {
      final idList = await localDataSource.getFavorites();
      return Right(idList);
    } on ApiResponseException catch (m) {
      return Left(ApiResponseFailure(message: m.message));
    } on TimeOutException {
      return Left(
          TimeOutFailure(/* message: 'aqui el mensaje que quieras cambiar' */));
    } catch (ex) {
      return Left(ServerFailure(message: "Error in Cache"));
    }
  }

  @override
  Future<Either<Failure, bool>> saveFavorite(String id) async {
    try {
      final response = await localDataSource.saveFavorite(id);
      return Right(response);
    } on ApiResponseException catch (m) {
      return Left(ApiResponseFailure(message: m.message));
    } on TimeOutException {
      return Left(
          TimeOutFailure(/* message: 'aqui el mensaje que quieras cambiar' */));
    } catch (ex) {
      return Left(ServerFailure(message: "Failure in Cache"));
    }
  }

  @override
  Future<Either<Failure, bool>> deleteFavorite(String id) async {
    try {
      final response = await localDataSource.deleteFavorite(id);
      return Right(response);
    } on ApiResponseException catch (m) {
      return Left(ApiResponseFailure(message: m.message));
    } on TimeOutException {
      return Left(
          TimeOutFailure(/* message: 'aqui el mensaje que quieras cambiar' */));
    } catch (ex) {
      return Left(ServerFailure(message: "Failure in Cache"));
    }
  }
}
