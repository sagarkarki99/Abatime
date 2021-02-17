import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/all_providers.dart';
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

  final Map<String, IconData> _icons = const {
    'Movies': Icons.personal_video,
    'Search': Icons.search,
    'Watch List': Icons.format_list_bulleted
  };

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
                items: _icons
                    .map(
                      (title, icon) => MapEntry(
                        title,
                        BottomNavigationBarItem(
                          icon: Icon(icon),
                          label: title,
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
      ),
    );
  }
}
