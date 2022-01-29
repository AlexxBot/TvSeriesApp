import 'package:dartz/dartz.dart';
import 'package:tvseries_app/core/error/exceptions.dart';
import 'package:tvseries_app/core/error/failures.dart';
import 'package:tvseries_app/core/network/network_info.dart';
import 'package:tvseries_app/features/show/data/datasources/show_remote_data.dart';
import 'package:tvseries_app/features/show/domain/entities/episode.dart';
import 'package:tvseries_app/features/show/domain/entities/show_filter.dart';
import 'package:tvseries_app/features/show/domain/entities/show_item.dart';
import 'package:tvseries_app/features/show/domain/repository/show_repository.dart';

class ShowRepositoryImple implements ShowRepository {
  final ShowRemoteData remoteDataSource;
  final NetworkInfo networkInfo;
  //final NetWor

  ShowRepositoryImple({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<ShowItem>>> search(ShowFilter filter) async {
    if (await networkInfo.isConnected) {
      try {
        final shows = await remoteDataSource.search(filter);
        return Right(shows);
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

  @override
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
}
