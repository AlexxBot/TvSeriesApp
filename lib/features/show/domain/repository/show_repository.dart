import 'package:dartz/dartz.dart';
import 'package:tvseries_app/core/error/failures.dart';
import 'package:tvseries_app/features/show/domain/entities/episode.dart';
import 'package:tvseries_app/features/show/domain/entities/show_filter.dart';
import 'package:tvseries_app/features/show/domain/entities/show_item.dart';
import 'package:tvseries_app/features/show/presentation/bloc/show_bloc.dart';

abstract class ShowRepository {
  Future<Either<Failure, List<ShowItem>>> search(ShowFilter showFilter);
  Future<Either<Failure, List<Episode>>> getEpisodes(String id);
}
