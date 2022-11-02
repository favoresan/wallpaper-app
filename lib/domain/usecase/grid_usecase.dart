import 'package:dartz/dartz.dart';
import 'package:wallpaper_demo/data/network/failure.dart';
import 'package:wallpaper_demo/domain/model/model.dart';
import 'package:wallpaper_demo/domain/repository/repository.dart';
import 'package:wallpaper_demo/domain/usecase/base_usecase.dart';

class GridUseCase implements BaseUseCase<void, Images> {
  Repository _repository;
  GridUseCase(this._repository);
  @override
  Future<Either<Failure, Images>> execute(void input) async {
    return await _repository.getGrid();
  }
}
