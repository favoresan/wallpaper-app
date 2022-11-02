import 'dart:async';

import 'package:flutter/material.dart';
import 'package:wallpaper_demo/presentation/resources/color_manager.dart';
import 'package:wallpaper_demo/presentation/resources/routes_manager.dart';
import 'package:wallpaper_demo/presentation/resources/value_manager.dart';

import '../resources/assets_manager.dart';

class SplashView extends StatefulWidget {
  SplashView({Key? key}) : super(key: key);

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  Timer? _timer;

  _startDelay() {
    _timer = Timer(Duration(seconds: 2), _goNext);
  }

  _goNext() {
    Navigator.pushReplacementNamed(context, Routes.mainRoute);
  }

  @override
  void initState() {
    _startDelay();
    super.initState();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.primary,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: AppPadding.p50),
        child: Center(
          child: Image.asset(
            ImageAssets.splashLogo,
          ),
        ),
      ),
    );
  }
}
