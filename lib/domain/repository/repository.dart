import 'package:dartz/dartz.dart';
import 'package:wallpaper_demo/domain/model/model.dart';

import '../../data/network/failure.dart';

abstract class Repository {
  Future<Either<Failure, Images>> getGrid();
  Future<Either<Failure, Images>> getSearch(SearchRequest searchRequest);
}
