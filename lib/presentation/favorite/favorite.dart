import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:wallpaper_demo/app/app_prefs.dart';
import 'package:wallpaper_demo/presentation/resources/assets_manager.dart';
import 'package:wallpaper_demo/presentation/resources/color_manager.dart';
import 'package:wallpaper_demo/provider.dart';

import '../../app/constant.dart';
import '../resources/routes_manager.dart';
import '../resources/strings_manager.dart';
import '../resources/value_manager.dart';

class FavoriteView extends ConsumerWidget {
  const FavoriteView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favImageList = ref.watch(favProvider);
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        children: [
          _gridFav(favImageList, context),
        ],
      ),
    );
  }

  _gridFav(List<String>? fav, BuildContext context) {
    if (fav != null && fav.length >= 1) {
      return Flex(
        direction: Axis.vertical,
        children: [
          GridView.count(
            crossAxisCount: 2,
            mainAxisSpacing: AppSize.s1,
            physics: ScrollPhysics(),
            shrinkWrap: true,
            childAspectRatio: AppSize.s0_6,
            crossAxisSpacing: AppSize.s1,
            children: List.generate(
              fav.length,
              (index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, Routes.favoriteImageRoute,
                        arguments: fav[index]);
                  },
                  child: Hero(
                    tag: fav[index],
                    child: Card(
                      shape: const RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.all(Radius.circular(AppSize.s8)),
                      ),
                      elevation: AppSize.s4,
                      child: ClipRRect(
                        borderRadius:
                            BorderRadius.all(Radius.circular(AppSize.s8)),
                        child: Image.network(
                          fav[index],
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      );
    } else {
      return
          // Container();
          Padding(
        padding: EdgeInsets.symmetric(horizontal: AppPadding.p20),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: AppSize.s120,
                width: AppSize.s120,
                child: Lottie.asset(JsonAssets.empty),
              ),
              Text(
                AppStrings.noFavorite,
                style: Theme.of(context).textTheme.headline3,
              ),
            ],
          ),
        ),
      );
    }
  }
}
