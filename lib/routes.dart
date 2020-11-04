import 'package:AbaTime/screens/screens.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Routes {
  static const homeScreen = '/home';
  static const movieDetailScreen = '/detailScreen';

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    return MaterialPageRoute(builder: (context) {
      switch (settings.name) {
        case homeScreen:
          return HomeScreen();
        case movieDetailScreen:
          return MovieDetailScreen(settings.arguments.toString());
        default:
          return HomeScreen();
      }
    });
  }
}
