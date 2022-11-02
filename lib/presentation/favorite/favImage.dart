import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_downloader/image_downloader.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wallpaper_demo/provider.dart';

import '../../app/app_prefs.dart';
import '../../app/constant.dart';
import '../../app/di.dart';
import '../resources/color_manager.dart';
import '../resources/strings_manager.dart';
import '../resources/value_manager.dart';

class FavouriteImage extends ConsumerStatefulWidget {
  String image;
  FavouriteImage({required this.image});
  @override
  ConsumerState<FavouriteImage> createState() => _FavouriteImageState();
}

class _FavouriteImageState extends ConsumerState<FavouriteImage> {
  AppPreferences _appPreferences = instance<AppPreferences>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.primary,
      body: Stack(
        children: [
          Hero(
            tag: widget.image,
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Image.network(
                widget.image,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height - 80,
            width: MediaQuery.of(context).size.width,
            alignment: Alignment.bottomCenter,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  // padding: EdgeInsets.all(
                  //   AppSize.s8,
                  // ),
                  height: AppSize.s50,
                  width: AppSize.s50,
                  decoration: BoxDecoration(
                    color: Color(0xff1c1b1b).withOpacity(0.8),
                    borderRadius: BorderRadius.all(
                      Radius.circular(
                        50,
                      ),
                    ),
                  ),
                  child: IconButton(
                    onPressed: () {
                      final b = ref.read(favProvider);
                      b.remove(widget.image);
                      _appPreferences.setFavorite(b);
                      // Navigator.pop(context);
                    },
                    icon: Icon(
                      Icons.clear,
                      color: ColorManager.pink,
                    ),
                  ),
                ),
                SizedBox(
                  height: AppSize.s12,
                ),
                Container(
                  // padding: EdgeInsets.all(
                  //   AppSize.s8,
                  // ),
                  height: AppSize.s50,
                  width: AppSize.s50,
                  decoration: BoxDecoration(
                    color: Color(0xff1c1b1b).withOpacity(0.8),
                    borderRadius: BorderRadius.all(
                      Radius.circular(
                        AppSize.s50,
                      ),
                    ),
                  ),
                  child: IconButton(
                    onPressed: () {
                      _saveNetworkImage();
                      _getPopUpDialog(context, [
                        Text(
                          AppStrings.done,
                          style: Theme.of(context).textTheme.headline1,
                        ),
                        Text(
                          AppStrings.imgD,
                          style: Theme.of(context).textTheme.headline3,
                        ),
                        SizedBox(
                          height: AppSize.s8,
                        ),
                        Divider(
                          color: ColorManager.lightGrey,
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text(
                            AppStrings.ok,
                          ),
                        ),
                      ]);
                    },
                    icon: Icon(
                      Icons.file_download_outlined,
                      color: ColorManager.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height - 730,
            width: MediaQuery.of(context).size.width / 4,
            alignment: Alignment.bottomCenter,
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                height: AppSize.s30,
                width: AppSize.s30,
                alignment: Alignment.bottomCenter,
                decoration: BoxDecoration(
                  color: Color(0xff1c1b1b).withOpacity(0.8),
                  borderRadius: BorderRadius.all(
                    Radius.circular(
                      AppSize.s50,
                    ),
                  ),
                ),
                child: Center(
                  child: Icon(
                    Icons.clear,
                    color: ColorManager.white,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _getPopUpDialog(BuildContext context, List<Widget> children) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSize.s14),
      ),
      elevation: AppSize.s1_5,
      backgroundColor: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
          color: ColorManager.transBlack.withOpacity(AppSize.s0_8),
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(AppSize.s14),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: AppSize.s12,
              offset: Offset(
                AppSize.s0,
                AppSize.s12,
              ),
            ),
          ],
        ),
        child: _getDialogContent(context, children),
      ),
    );
  }

  Widget _getDialogContent(BuildContext context, List<Widget> children) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: children,
    );
  }

  void _saveNetworkImage() {
    ImageDownloader.downloadImage(widget.image);
    Navigator.pop(context);
  }
}
