import 'package:AbaTime/provider/MoviesProvider.dart';
import 'package:AbaTime/screens/HomeScreen.dart';
import 'package:AbaTime/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NavScreen extends StatefulWidget {
  NavScreen({Key key}) : super(key: key);

  @override
  _NavScreenState createState() => _NavScreenState();
}

class _NavScreenState extends State<NavScreen> {
  var _currentIndex = 0;

  List<Widget> _screens = [
    ChangeNotifierProvider(
      create: (context) => MovieProvider(),
      child: HomeScreen(
        key: PageStorageKey('HomeScreen'),
      ),
    ),
    Scaffold(),
    Scaffold(),
    Scaffold(),
    Scaffold(),
  ];

  final Map<String, IconData> _icons = const {
    'Home': Icons.home,
    'Search': Icons.search,
    'Coming Soon': Icons.queue_play_next,
    'Downloads': Icons.file_download,
    'More': Icons.menu
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: ResponsiveWidget.isMobile(context)
          ? BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              items: _icons
                  .map(
                    (title, icon) => MapEntry(
                      title,
                      BottomNavigationBarItem(
                        icon: Icon(icon),
                        title: Text(title),
                      ),
                    ),
                  )
                  .values
                  .toList(),
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
    );
  }
}
