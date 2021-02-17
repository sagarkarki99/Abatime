import 'package:AbaTime/providers/detail_provider.dart';
import 'package:AbaTime/ui/screens/screens.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Routes {
  static const homeScreen = '/home';
  static const movieDetailScreen = '/detailScreen';

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    return MaterialPageRoute(builder: (context) {
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
    });
  }
}
