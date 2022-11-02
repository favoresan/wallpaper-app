import 'package:flutter/material.dart';
import 'package:wallpaper_demo/presentation/resources/styles_manager.dart';
import 'package:wallpaper_demo/presentation/resources/value_manager.dart';

import 'color_manager.dart';
import 'font_manager.dart';

ThemeData getApplicationTheme() {
  return ThemeData(
    //main colors of the app
    primaryColor: ColorManager.primary,
    // primaryColorLight: ColorManager.primaryOpacity70,
    // primaryColorDark: ColorManager.darkPrimary,
    colorScheme:
        ColorScheme.fromSwatch().copyWith(secondary: ColorManager.lightGrey),
    //ripple color
    // splashColor: ColorManager.primaryOpacity70,
    disabledColor:
        ColorManager.lightGrey, //will be used incase of disabled btns
    //card view theme
    cardTheme: CardTheme(
      color: ColorManager.primary,
      shadowColor: ColorManager.primary,
      elevation: AppSize.s4,
    ),
    //button theme
    buttonTheme: ButtonThemeData(
      splashColor: ColorManager.primary,
      shape: StadiumBorder(),
      disabledColor: ColorManager.lightGrey,
      buttonColor: ColorManager.darkPink,
      // splashColor: ColorManager.primaryOpacity70,
    ),
    //elevated btnTheme
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
            textStyle: getRegularStyle(
              color: ColorManager.darkPink,
            ),
            primary: ColorManager.search,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppSize.s12)))),
    //text theme
    textTheme: TextTheme(
        headline1:
            getSemiBoldStyle(color: ColorManager.white, fontSize: FontSize.s16),
        headline2:
            getBoldStyle(color: ColorManager.white, fontSize: FontSize.s18),
        headline3:
            getRegularStyle(color: ColorManager.white, fontSize: FontSize.s13),
        headline4:
            getRegularStyle(color: ColorManager.white, fontSize: FontSize.s10),
        subtitle1: getMediumStyle(
            color: ColorManager.lightGrey, fontSize: FontSize.s14),
        subtitle2:
            getBoldStyle(color: ColorManager.white, fontSize: FontSize.s14),
        caption: getRegularStyle(
          color: ColorManager.black,
        ),
        bodyText1: getRegularStyle(color: ColorManager.darkPink)),
    //appBar theme
    appBarTheme: AppBarTheme(
      color: ColorManager.primary,
      centerTitle: true,
      elevation: AppSize.s4,
      shadowColor: ColorManager.primary,
      titleTextStyle:
          getRegularStyle(color: ColorManager.black, fontSize: FontSize.s16),
    ),
    //inputDecoration theme (textForm field)
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderSide: BorderSide(
          color: ColorManager.primary,
          width: AppSize.s1_5,
        ),
        borderRadius: BorderRadius.circular(
          AppSize.s50,
        ),
      ),
      fillColor: ColorManager.search,
      filled: true,
      contentPadding: EdgeInsets.all(AppPadding.p8),
      //hintStyle
      hintStyle: getRegularStyle(
          color: ColorManager.lightGrey, fontSize: FontSize.s14),
      //label style
      labelStyle: getMediumStyle(
        color: ColorManager.darkPink,
      ),
      //error style
      errorStyle: getRegularStyle(
        color: ColorManager.error,
      ),
      //enabled border
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: ColorManager.primary,
          width: AppSize.s1_5,
        ),
        borderRadius: BorderRadius.circular(
          AppSize.s50,
        ),
      ),
      //focused border
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: ColorManager.lightGrey,
          width: AppSize.s1_5,
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(
            AppSize.s50,
          ),
        ),
      ),
      //error border
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: ColorManager.error,
          width: AppSize.s1_5,
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(
            AppSize.s50,
          ),
        ),
      ),
      //focused error border
      focusedErrorBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: ColorManager.white,
          width: AppSize.s1_5,
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(
            AppSize.s50,
          ),
        ),
      ),
    ),
  );
}
