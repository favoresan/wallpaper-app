// import 'package:advanced/data/request/request.dart';
//
// import '../../network/app_api.dart';
// import '../../responses/responses.dart';
//
import 'package:wallpaper_demo/app/constant.dart';
import 'package:wallpaper_demo/data/responses/responses.dart';
import 'package:wallpaper_demo/domain/model/model.dart';

import '../network/app_api.dart';

abstract class RemoteDataSource {
  Future<ImageResponse> getGrid();
  Future<ImageResponse> getSearch(SearchRequest searchRequest);
}

//
class RemoteDataSourceImplementer implements RemoteDataSource {
  AppServiceClient _appServiceClient;
  RemoteDataSourceImplementer(this._appServiceClient);

  @override
  Future<ImageResponse> getGrid() async {
    return await _appServiceClient.getGrid(
        Constant.pageSize, Constant.currentPage, Constant.apiKey);
  }

  @override
  Future<ImageResponse> getSearch(SearchRequest searchRequest) async {
    return await _appServiceClient.getSearch(Constant.pageSize,
        Constant.currentPage, searchRequest.search, Constant.apiKey);
  }
}
