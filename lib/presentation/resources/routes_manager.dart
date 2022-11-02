import 'package:flutter/material.dart';
import 'package:wallpaper_demo/presentation/category/category.dart';
import 'package:wallpaper_demo/presentation/favorite/favImage.dart';
import 'package:wallpaper_demo/presentation/favorite/favorite.dart';
import 'package:wallpaper_demo/presentation/home/home.dart';
import 'package:wallpaper_demo/presentation/main/main_nav.dart';
import 'package:wallpaper_demo/presentation/resources/strings_manager.dart';
import 'package:wallpaper_demo/presentation/search/search.dart';
import 'package:wallpaper_demo/presentation/splash/splash.dart';

import '../../app/di.dart';
import '../recommend/image.dart';

class Routes {
  static const String splashRoute = '/';
  static const String mainRoute = '/main';
  static const String searchRoute = '/search';
  static const String imageRoute = '/image';
  static const String categoryRoute = '/category';
  static const String favoriteRoute = '/favorite';
  static const String favoriteImageRoute = '/favoriteImage';
}

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case Routes.splashRoute:
        return MaterialPageRoute(builder: (_) => SplashView());
      case Routes.mainRoute:
        initGridModule();
        return MaterialPageRoute(builder: (_) => MainNav());
      case Routes.searchRoute:
        initSearchModule();
        return MaterialPageRoute(
            builder: (_) =>
                SearchView(search: routeSettings.arguments as String));
      case Routes.categoryRoute:
        initCategoryModule();
        return MaterialPageRoute(
          builder: (_) =>
              CategoryView(categorySearch: routeSettings.arguments as String),
        );
      case Routes.imageRoute:
        return MaterialPageRoute(
            builder: (_) => ImageView(routeSettings.arguments as String));
      case Routes.favoriteImageRoute:
        return MaterialPageRoute(
            builder: (_) => FavouriteImage(image: routeSettings.arguments as String));
      // case Routes.favoriteRoute:
      //   return MaterialPageRoute(builder: (_) => FavoriteView());
      default:
        return unDefinedRoute();

    }
  }

  static Route<dynamic> unDefinedRoute() {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(
          title: Text(
            AppStrings.noRouteFound,
          ),
        ),
        body: Center(
          child: Text(AppStrings.noRouteFound),
        ),
      ),
    );
  }
}
