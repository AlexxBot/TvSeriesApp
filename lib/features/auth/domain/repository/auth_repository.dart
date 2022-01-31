import 'package:dartz/dartz.dart';
import 'package:tvseries_app/core/error/failures.dart';
import 'package:tvseries_app/features/show/domain/entities/episode.dart';
import 'package:tvseries_app/features/show/domain/entities/show_filter.dart';
import 'package:tvseries_app/features/show/domain/entities/show_item.dart';
import 'package:tvseries_app/features/show/presentation/bloc/show_bloc.dart';

abstract class AuthRepository {
  Future<Either<Failure, bool>> setPin(String pin);
  Future<Either<Failure, String>> getPin();
  Future<Either<Failure, List<String>>> getFavorites();
  Future<Either<Failure, bool>> saveFavorite(String id);
  Future<Either<Failure, bool>> deleteFavorite(String id);
  Future<Either<Failure, bool>> existFavorite(String id);
}
