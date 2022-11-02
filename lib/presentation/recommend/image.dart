import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wallpaper_demo/presentation/resources/color_manager.dart';
import 'package:wallpaper_demo/presentation/resources/strings_manager.dart';
import 'package:wallpaper_demo/provider.dart';
import '../../app/app_prefs.dart';
import '../../app/di.dart';
import '../resources/value_manager.dart';
import 'package:image_downloader/image_downloader.dart';
import 'package:wallpaper_demo/app/constant.dart';
import 'dart:io' show Platform;

class ImageView extends ConsumerStatefulWidget {
  String image;
  ImageView(this.image);

  @override
  ConsumerState<ImageView> createState() => _ImageViewState();
}

class _ImageViewState extends ConsumerState<ImageView> {
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
                      b.add(widget.image);
                      _appPreferences.setFavorite(b);
                      _showAlertDialog(
                          context: context,
                          title: AppStrings.done,
                          content: AppStrings.added);
                    },
                    icon: Icon(
                      Icons.favorite,
                      color: ColorManager.white,
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
                      _showAlertDialog(
                          context: context,
                          title: AppStrings.done,
                          content: AppStrings.imgD);
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
          color: ColorManager.lightGrey,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(AppSize.s14),
          boxShadow: const [
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
  }

  Future _showAlertDialog(
      {required BuildContext context,
      required String title,
      required String content}) async {
    if (!Platform.isIOS) {
      return showDialog(
          context: context,
          builder: (context) => AlertDialog(
                backgroundColor: ColorManager.transBlack,
                title: Text(title),
                content: Text(content),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      AppStrings.ok,
                    ),
                  ),
                ],
              ));
    } else {
      return showCupertinoDialog(
          context: context,
          builder: (context) => Theme(
                data: ThemeData.dark(),
                child: CupertinoAlertDialog(
                  title: Text(title),
                  content: Text(content),
                  actions: [
                    CupertinoDialogAction(
                      child: Text(
                        AppStrings.ok,
                      ),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
              ));
    }
  }
}

// Color(0xff1c1b1b).withOpacity(0.8),

// Stack(
// children: [
// Container(
// decoration: BoxDecoration(
// borderRadius: BorderRadius.all(
// Radius.circular(
// AppSize.s50,
// ),
// ),
// color: Color(0xff1c1b1b).withOpacity(0.8),
// ),
// height: AppSize.s50,
// width: MediaQuery.of(context).size.width / 2,
// ),
// GestureDetector(
// onTap: () {
// _saveNetworkImage();
// },
// child: Container(
// height: AppSize.s50,
// width: MediaQuery.of(context).size.width / 2,
// padding: EdgeInsets.symmetric(
// vertical: AppPadding.p8,
// horizontal: AppPadding.p12),
// decoration: BoxDecoration(
// border: Border.all(color: ColorManager.lightGrey),
// gradient: const LinearGradient(colors: [
// Color(
// 0x36ffffff,
// ),
// Color(
// 0x0fffffff,
// ),
// ]),
// borderRadius: BorderRadius.all(
// Radius.circular(
// AppSize.s50,
// ),
// ),
// ),
// child: Column(
// children: [
// Text(
// AppStrings.setWallpaper,
// style: Theme.of(context).textTheme.headline3,
// ),
// // SizedBox(
// //   height: AppSize.s8,
// // ),
// Text(
// AppStrings.imgToGallery,
// style: Theme.of(context).textTheme.headline4,
// ),
// ],
// ),
// ),
// ),
// ],
// ),
