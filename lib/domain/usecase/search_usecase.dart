import 'package:dartz/dartz.dart';
import 'package:wallpaper_demo/data/network/failure.dart';
import 'package:wallpaper_demo/domain/model/model.dart';
import 'package:wallpaper_demo/domain/repository/repository.dart';
import 'package:wallpaper_demo/domain/usecase/base_usecase.dart';

class SearchUseCase implements BaseUseCase<SearchUseCaseInput, Images> {
  Repository _repository;
  SearchUseCase(this._repository);
  @override
  Future<Either<Failure, Images>> execute(SearchUseCaseInput input) async {
    return await _repository.getSearch(SearchRequest(search: input.search));
  }
}

class SearchUseCaseInput {
  String search;
  SearchUseCaseInput(this.search);
}
