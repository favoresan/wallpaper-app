import 'package:retrofit/http.dart';
import 'package:dio/dio.dart';
import 'package:wallpaper_demo/app/constant.dart';

import '../responses/responses.dart';
part 'app_api.g.dart';

@RestApi(baseUrl: Constant.baseUrl)
abstract class AppServiceClient {
  factory AppServiceClient(Dio dio, {String baseUrl}) = _AppServiceClient;
  @GET('/v1/curated')
  Future<ImageResponse> getGrid(
    @Query("per_page") int page,
    @Query('page') int list,
    @Header('Authorization') String apiKey,
  );

  @GET('/v1/search')
  Future<ImageResponse> getSearch(
    @Query("per_page") int page,
    @Query('page') int list,
    @Query('query') String search,
    @Header('Authorization') String apiKey,
  );
}
