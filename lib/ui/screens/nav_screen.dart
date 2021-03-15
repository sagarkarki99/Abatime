import 'package:abatime/providers/all_providers.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/widgets.dart';
import 'screens.dart';

class NavScreen extends StatefulWidget {
  NavScreen({Key key}) : super(key: key);

  @override
  _NavScreenState createState() => _NavScreenState();
}

class _NavScreenState extends State<NavScreen> {
  var _currentIndex = 0;
  bool isPop = false;

  List<Widget> _screens = [
    ChangeNotifierProvider(
      create: (_) => GenreProvider(),
      builder: (context, _) => HomeScreen(
        key: PageStorageKey('HomeScreen'),
      ),
    ),
    SearchScreen(),
    WatchListScreen(),
  ];

  final List<BottomNavigationBarItem> _items = [
    BottomNavigationBarItem(
        icon: Icon(FluentIcons.tv_24_regular),
        activeIcon: Icon(FluentIcons.tv_24_filled),
        label: 'Movies'),
    BottomNavigationBarItem(
        icon: Icon(FluentIcons.search_24_regular),
        activeIcon: Icon(FluentIcons.search_24_filled),
        label: 'Search'),
    BottomNavigationBarItem(
        icon: Icon(FluentIcons.list_24_regular),
        activeIcon: Icon(FluentIcons.list_24_filled),
        label: 'Watch List'),
  ];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (_currentIndex != 0) {
          setState(() {
            _currentIndex = 0;
          });
          return false;
        }
        return true;
      },
      child: Scaffold(
        bottomNavigationBar: ResponsiveWidget.isMobile(context)
            ? BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                items: _items,
                backgroundColor: Colors.black,
                currentIndex: _currentIndex,
                selectedItemColor: Colors.white,
                selectedFontSize: 14,
                unselectedItemColor: Colors.grey,
                unselectedFontSize: 11,
                onTap: (value) => setState(() => _currentIndex = value),
              )
            : null,
        body: _screens[_currentIndex],
      ),
    );
  }
}
