import 'package:dartz/dartz.dart';
import 'package:tvseries_app/core/error/failures.dart';
import 'package:tvseries_app/features/show/domain/entities/show_filter.dart';
import 'package:tvseries_app/features/show/domain/entities/show_item.dart';

abstract class ShowRepository {
  Future<Either<Failure, List<ShowItem>>> search(ShowFilter showFilter);
}
