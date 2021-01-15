import 'dart:io';

import 'package:AbaTime/config/theme.dart';
import 'package:AbaTime/providers/all_providers.dart';
import 'package:AbaTime/screens/screens.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'screens/screens.dart';
import 'routes.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: MovieProvider(),
      child: Platform.isIOS
          ? CupertinoApp()
          : MaterialApp(
              title: 'Aba Time',
              debugShowCheckedModeBanner: false,
              theme: MyTheme.customTheme(),
              home: NavScreen(),
              onGenerateRoute: Routes.onGenerateRoute,
            ),
    );
  }
}
