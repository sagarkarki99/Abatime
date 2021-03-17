import 'package:abatime/providers/detail_provider.dart';
import 'package:abatime/ui/screens/screens.dart';
import 'package:abatime/ui/ui_utils.dart/screen_transition.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
        return ChangeNotifierProvider(
          create: (_) => DetailProvider(),
          child: MovieDetailScreen(
            settings.arguments.toString(),
          ),
        );
      default:
        return HomeScreen();
    }
  }
}
