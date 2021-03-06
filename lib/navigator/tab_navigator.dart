import 'package:flutter/material.dart';
import 'package:tour/pages/home_page.dart';
import 'package:tour/pages/search_page.dart';
import 'package:tour/pages/travel_page.dart';
import 'package:tour/pages/my_page.dart';


class TabNavigator extends StatefulWidget {
  @override
  _TabNavigatorState createState() => _TabNavigatorState();
}

class _TabNavigatorState extends State<TabNavigator> {
  final _defaultColor = Colors.grey;
  final _activeColor = Colors.blue;
  int _currentIndex = 0;
  final _controller = PageController(
    initialPage:0,
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _controller,
        children: <Widget>[
          HomePage(),
          SearchPage(),
          TravelPage(),
          MyPage(),
        ],
        // 禁止滑动
        physics: NeverScrollableScrollPhysics(),
      ),
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            _controller.jumpToPage(index);
            setState(() {
              _currentIndex = index;
            });
          },
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.home, color: _defaultColor),
                activeIcon: Icon(Icons.home, color: _activeColor),
                title: Text('Home', style: TextStyle(
                    color: _currentIndex != 0 ? _defaultColor : _activeColor))
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.search, color: _defaultColor),
                activeIcon: Icon(Icons.search, color: _activeColor),
                title: Text('Search', style: TextStyle(
                    color: _currentIndex != 1 ? _defaultColor : _activeColor))
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.camera_alt, color: _defaultColor),
                activeIcon: Icon(Icons.camera_alt, color: _activeColor),
                title: Text('Travel', style: TextStyle(
                    color: _currentIndex != 2 ? _defaultColor : _activeColor))
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.account_circle, color: _defaultColor),
                activeIcon: Icon(Icons.account_circle, color: _activeColor),
                title: Text('My', style: TextStyle(
                    color: _currentIndex != 3 ? _defaultColor : _activeColor))
            ),
          ]
      ),
    );
  }
}
