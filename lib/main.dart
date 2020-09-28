import 'dart:io';

import 'package:AbaTime/config/theme.dart';
import 'package:AbaTime/screens/MovieDetailScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'screens/screens.dart';
import 'routes.dart' as routes;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoApp()
        : MaterialApp(
            title: 'Aba Time',
            debugShowCheckedModeBanner: false,
            theme: MyTheme.customTheme(),
            home: NavScreen(),
            routes: {
              routes.homeScreen: (_) => HomeScreen(),
              routes.movieDetailScreen: (_) => MovieDetailScreen()
            },
          );
  }
}
