import 'dart:io';

import 'package:abatime/config/theme.dart';
import 'package:abatime/config/utils/ad_manager.dart';
import 'package:abatime/providers/all_providers.dart';
import 'package:abatime/ui/screens/screens.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';

import 'routes.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  final initFuture = MobileAds.instance.initialize();
  final adManager = AdManager(initFuture);
  runApp(
    Provider.value(
      value: adManager,
      builder: (_, __) => MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Future.delayed(
          Duration(
            seconds: 3,
          ),
        ),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              home: SplashScreen(),
            );
          } else {
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
        });
  }
}
