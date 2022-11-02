import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wallpaper_demo/presentation/favorite/favorite.dart';
import 'package:wallpaper_demo/presentation/home/home.dart';
import 'package:wallpaper_demo/provider.dart';

import '../resources/color_manager.dart';
import '../resources/strings_manager.dart';
import '../resources/value_manager.dart';

class MainNav extends ConsumerWidget {
  MainNav({Key? key}) : super(key: key);

  List<Widget> pages = [
    MyHomePage(),
    FavoriteView(),
  ];
  List<String> titles = [
    AppStrings.wallpaper,
    AppStrings.favorite,
  ];
  var _title = AppStrings.wallpaper;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    unFocus() {
      FocusScopeNode currentFocus = FocusScope.of(context);
      if (!currentFocus.hasPrimaryFocus) {
        currentFocus.unfocus();
      }
    }

    final numIndex = ref.watch(numProvider);
    var _currentIndex = numIndex;
    return GestureDetector(
      onTap: () {
        unFocus();
      },
      child: Scaffold(
        backgroundColor: ColorManager.primary,
        appBar: AppBar(
          elevation: AppSize.s0,
          title: Text(
            _title,
            style: Theme.of(context).textTheme.headline2,
          ),
        ),
        body: pages[_currentIndex],
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            color: ColorManager.primary,
            boxShadow: [
              BoxShadow(
                color: ColorManager.black,
                spreadRadius: AppSize.s1,
              ),
            ],
          ),
          child: BottomNavigationBar(
            backgroundColor: ColorManager.primary,
            showUnselectedLabels: false,
            showSelectedLabels: false,
            selectedItemColor: ColorManager.white,
            unselectedItemColor: ColorManager.lightGrey,
            currentIndex: _currentIndex,
            onTap: (int index) {
              ref.read(numProvider.notifier).state = index;
              _title = titles[index];
            },
            items: const [
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.grid_view_sharp,
                  size: AppSize.s40,
                ),
                label: AppStrings.wallpaper,
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.star,
                  size: AppSize.s40,
                ),
                label: AppStrings.favorite,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
