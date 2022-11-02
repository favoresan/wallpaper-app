import 'package:dartz/dartz.dart';
import 'package:wallpaper_demo/data/data_source/remote_data_source.dart';
import 'package:wallpaper_demo/data/data_source/local_data_source.dart';
import 'package:wallpaper_demo/data/error_handler.dart';
import 'package:wallpaper_demo/data/mapper/mapper.dart';
import 'package:wallpaper_demo/data/network/failure.dart';
import 'package:wallpaper_demo/data/network/network_info.dart';
import 'package:wallpaper_demo/domain/model/model.dart';
import 'package:wallpaper_demo/domain/repository/repository.dart';

class RepositoryImpl extends Repository {
  NetworkInfo _networkInfo;
  RemoteDataSource _remoteDataSource;
  LocalDataSource _localDataSource;
  RepositoryImpl(
      this._remoteDataSource, this._networkInfo, this._localDataSource);
  @override
  Future<Either<Failure, Images>> getGrid() async {
    //u r caching 2 things in one place
    try {
      final response = await _localDataSource.getGrid();
      return Right(response.toDomain());
    } catch (cacheError) {
      if (await _networkInfo.isConnected) {
        try {
          final response = await _remoteDataSource.getGrid();
          if (response.grid != null) {
            _localDataSource.saveHomeToCache(response);
            return Right(response.toDomain());
          } else {
            return Left(Failure(ResponseCode.DEFAULT, ResponseMessage.DEFAULT));
          }
        } catch (err) {
          return Left(ErrorHandler.handle(err).failure);
        }
      } else {
        return Left(Failure(ResponseCode.NO_INTERNET_CONNECTION,
            ResponseMessage.NO_INTERNET_CONNECTION));
      }
    }
  }

  @override
  Future<Either<Failure, Images>> getSearch(SearchRequest searchRequest) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _remoteDataSource.getSearch(searchRequest);
        if (response.grid != null) {
          return Right(response.toDomain());
        } else {
          return Left(Failure(ResponseCode.DEFAULT, ResponseMessage.DEFAULT));
        }
      } catch (err) {
        return Left(ErrorHandler.handle(err).failure);
      }
    } else {
      return Left(Failure(ResponseCode.NO_INTERNET_CONNECTION,
          ResponseMessage.NO_INTERNET_CONNECTION));
    }
  }
}
