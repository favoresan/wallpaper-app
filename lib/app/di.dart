import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wallpaper_demo/presentation/recommend/image.dart';

import '../data/data_source/local_data_source.dart';
import '../data/data_source/remote_data_source.dart';
import '../data/network/app_api.dart';
import '../data/network/dio_factory.dart';
import '../data/network/network_info.dart';
import '../data/repository/repository_impl.dart';
import '../domain/repository/repository.dart';
import '../domain/usecase/category_usecase.dart';
import '../domain/usecase/grid_usecase.dart';
import '../domain/usecase/search_usecase.dart';
import '../presentation/category/category_viewmodel.dart';
import '../presentation/home/home_viewmodel.dart';
import '../presentation/search/search_viewmodel.dart';
import 'app_prefs.dart';

final instance = GetIt.instance;

Future<void> initAppModule() async {
  final sharedPrefs = await SharedPreferences.getInstance();
  //shared prefs instance
  instance.registerLazySingleton<SharedPreferences>(() => sharedPrefs);
  //app prefs instance
  instance
      .registerLazySingleton<AppPreferences>(() => AppPreferences(instance()));
  // //network info
  instance.registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImpl(DataConnectionChecker()));
  //dio factory
  instance.registerLazySingleton<DioFactory>(() => DioFactory());
  //app service client
  final dio = await instance<DioFactory>().getDio();
  instance.registerLazySingleton<AppServiceClient>(() => AppServiceClient(dio));
  //remote data source
  instance.registerLazySingleton<RemoteDataSource>(
      () => RemoteDataSourceImplementer(instance()));
  //local data source
  instance.registerLazySingleton<LocalDataSource>(
      () => LocalDataSourceImplementer());
  //repository
  instance.registerLazySingleton<Repository>(() => RepositoryImpl(
        instance(),
        instance(),
        instance(),
      ));
}

initGridModule() {
  if (!GetIt.I.isRegistered<GridUseCase>()) {
    instance.registerFactory<GridUseCase>(() => GridUseCase(instance()));
    instance.registerFactory<HomeViewModel>(() => HomeViewModel(instance()));
  }
}

initSearchModule() {
  if (!GetIt.I.isRegistered<SearchUseCase>()) {
    instance.registerFactory<SearchUseCase>(() => SearchUseCase(instance()));
    instance
        .registerFactory<SearchViewModel>(() => SearchViewModel(instance()));
  }
}

initCategoryModule() {
  if (!GetIt.I.isRegistered<CategoryUseCase>()) {
    instance
        .registerFactory<CategoryUseCase>(() => CategoryUseCase(instance()));
    instance.registerFactory<CategoryViewModel>(
        () => CategoryViewModel(instance()));
  }
}
