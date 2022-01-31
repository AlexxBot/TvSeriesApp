import 'package:dartz/dartz.dart';
import 'package:tvseries_app/core/error/failures.dart';
import 'package:tvseries_app/features/auth/domain/repository/auth_repository.dart';

abstract class UseCase {
  Future<Either<Failure, List<String>>> getFavorites();

  Future<Either<Failure, bool>> saveFavorite(String id);

  Future<Either<Failure, bool>> deleteFavorite(String id);

  Future<Either<Failure, bool>> existFavorite(String id);

  Future<Either<Failure, String>> getPin();

  Future<Either<Failure, bool>> setPin(String pin);
}

class AuthUseCase implements UseCase {
  final AuthRepository repository;
  AuthUseCase(this.repository);

  @override
  Future<Either<Failure, List<String>>> getFavorites() async {
    return await repository.getFavorites();
  }

  @override
  Future<Either<Failure, bool>> saveFavorite(String id) async {
    return await repository.saveFavorite(id);
  }

  @override
  Future<Either<Failure, bool>> deleteFavorite(String id) async {
    return await repository.deleteFavorite(id);
  }

  @override
  Future<Either<Failure, bool>> existFavorite(String id) async {
    return await repository.existFavorite(id);
  }

  @override
  Future<Either<Failure, String>> getPin() async {
    return await repository.getPin();
  }

  @override
  Future<Either<Failure, bool>> setPin(String pin) async {
    return await repository.setPin(pin);
  }
}
