import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyTheme {
  const MyTheme({Key key});
  static final _appPrimaryColor = Colors.blue;
  static final _appAccentColor = Colors.purple;
  static final _appSecondaryColor = Color(0xFF232323);
  static ThemeData _myAndroidTheme(ThemeData baseTheme) {
    return baseTheme.copyWith(
      brightness: Brightness.light,
      primaryColor: _appPrimaryColor,
      secondaryHeaderColor: _appSecondaryColor,
      accentColor: _appAccentColor,
      errorColor: Colors.red[700],
      visualDensity: VisualDensity.adaptivePlatformDensity,
      scaffoldBackgroundColor: Colors.black,
      textTheme: _myAppTextTheme(baseTheme.textTheme),
      primaryTextTheme: _myAppTextTheme(baseTheme.textTheme),
      accentTextTheme: _myAppTextTheme(baseTheme.textTheme),
      appBarTheme: AppBarTheme(
        color: Colors.black,
        brightness: Brightness.light,
        elevation: 4,
        textTheme: TextTheme(
          bodyText2: GoogleFonts.radley().copyWith(color: Colors.black),
        ),
      ),
      buttonTheme: baseTheme.buttonTheme.copyWith(
        buttonColor: Colors.white,
        textTheme: ButtonTextTheme.primary,
      ),
    );
  }

  static _myIosTheme(ThemeData themeData) {
    return CupertinoThemeData(
        scaffoldBackgroundColor: Colors.white,
        brightness: Brightness.light,
        primaryColor: _appPrimaryColor,
        textTheme: _myAppTextTheme(themeData.textTheme));
  }

  static _myAppTextTheme(TextTheme baseTextTheme) {
    return baseTextTheme
        .copyWith(
          headline5: baseTextTheme.headline5.copyWith(
            fontWeight: FontWeight.w500,
          ),
          headline6: baseTextTheme.headline6.copyWith(
            fontSize: 18.0,
          ),
          headline4: TextStyle(
            fontFamily: 'Satisfy',
          ),
          caption: baseTextTheme.caption.copyWith(
            fontWeight: FontWeight.w400,
          ),
          bodyText1: baseTextTheme.bodyText1.copyWith(
            fontWeight: FontWeight.w500,
            fontSize: 16.0,
          ),
        )
        .apply(displayColor: Colors.white, bodyColor: Colors.white);
  }

  static ThemeData customTheme() {
    return Platform.isAndroid
        ? _myAndroidTheme(ThemeData.dark())
        : _myIosTheme(ThemeData.light());
  }
}
