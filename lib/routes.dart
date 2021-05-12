import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'ui/screens/screens.dart';
import 'ui/ui_utils.dart/screen_transition.dart';

class Routes {
  static const homeScreen = '/home';
  static const movieDetailScreen = '/detailScreen';

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    return ScreenTransition(page: _getScreen(settings));
  }

  static Widget _getScreen(RouteSettings settings) {
    switch (settings.name) {
      case homeScreen:
        return HomeScreen();
      case movieDetailScreen:
        return MovieDetailScreen(
          settings.arguments.toString(),
        );

      default:
        return HomeScreen();
    }
  }
}
