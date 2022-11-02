import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../../data/mapper/mapper.dart';
import '../../../data/network/failure.dart';
import '../../resources/assets_manager.dart';
import '../../resources/color_manager.dart';
import '../../resources/font_manager.dart';
import '../../resources/strings_manager.dart';
import '../../resources/styles_manager.dart';
import '../../resources/value_manager.dart';

enum StateRendererType {
  //popup states
  LOADING_STATE,
  ERROR_STATE,
  //fullscreen states
  FULLSCREEN_LOADING_STATE,
  FULLSCREEN_ERROR_STATE,

  CONTENT_SCREEN_STATE,
  EMPTY_SCREEN_STATE,
}

class StateRenderer extends StatelessWidget {
  StateRendererType stateRendererType;

  String message, title;
  Function? retryActionFunction;

  StateRenderer(
      {Key? key,
      String? message,
      String? title,
      required this.retryActionFunction,
      required this.stateRendererType})
      : message = message ?? AppStrings.loading,
        title = title ?? EMPTY,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return _getStateWidget(context);
  }

  Widget _getStateWidget(BuildContext context) {
    switch (stateRendererType) {
      case StateRendererType.LOADING_STATE:
        return _getItemsInColumn([_getAnimatedImage(JsonAssets.loading)]);
      case StateRendererType.ERROR_STATE:
        return _getItemsInColumn(
            [_getAnimatedImage(JsonAssets.error), _getMessage(message)]);
      case StateRendererType.FULLSCREEN_LOADING_STATE:
        return _getItemsInColumnFull(
            [_getAnimatedImage(JsonAssets.loading), _getMessage(message)]);
      case StateRendererType.FULLSCREEN_ERROR_STATE:
        return _getItemsInColumnFull([
          _getAnimatedImage(JsonAssets.error),
          _getMessage(message),
          _getElevatedBtn(AppStrings.retryAgain, context),
        ]);
      case StateRendererType.CONTENT_SCREEN_STATE:
        return Container();

      case StateRendererType.EMPTY_SCREEN_STATE:
        return _getItemsInColumnFull(
            [_getAnimatedImage(JsonAssets.empty), _getMessage(message)]);

      default:
        return Container();
    }
  }

  Widget _getAnimatedImage(String animationName) {
    return SizedBox(
      height: AppSize.s100,
      width: AppSize.s100,
      child: Lottie.asset(animationName), //json image
    );
  }

  Widget _getMessage(String message) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppPadding.p18),
        child: Text(
          message,
          style: getMediumStyle(
              color: ColorManager.lightGrey, fontSize: FontSize.s16),
        ),
      ),
    );
  }

  Widget _getTitle(String title) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppPadding.p18),
        child: Text(
          title,
          style: getMediumStyle(
              color: ColorManager.lightGrey, fontSize: FontSize.s16),
        ),
      ),
    );
  }

  Widget _getElevatedBtn(String btnTitle, BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppPadding.p18),
        child: SizedBox(
          width: AppSize.s180,
          child: ElevatedButton(
              onPressed: () {
                if (stateRendererType ==
                    StateRendererType.FULLSCREEN_ERROR_STATE) {
                  retryActionFunction
                      ?.call(); //to call the api function to retry
                } else {
                  Navigator.of(context)
                      .pop(); //dismiss dialog od popup state error
                }
              },
              child: Text(btnTitle)),
        ),
      ),
    );
  }

  Widget _getItemsInColumnFull(List<Widget> children) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: children,
      ),
    );
  }

  Widget _getItemsInColumn(List<Widget> children) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: children,
    );
  }
}
