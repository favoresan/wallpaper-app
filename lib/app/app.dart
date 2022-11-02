import 'package:flutter/material.dart';
import 'package:wallpaper_demo/presentation/resources/routes_manager.dart';
import 'package:wallpaper_demo/presentation/resources/theme_manager.dart';
import '../presentation/home/home.dart';

class MyApp extends StatelessWidget {
  MyApp._internal();
  int appState = 0;
  static final MyApp instance = MyApp._internal();
  factory MyApp() => instance;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: RouteGenerator.getRoute,
      initialRoute: Routes.splashRoute,
      title: 'WallpaperHub',
      theme: getApplicationTheme(),
    );
  }
}
