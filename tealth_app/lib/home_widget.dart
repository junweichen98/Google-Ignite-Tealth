import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'homepage_widget.dart';
import 'settings_widget.dart';
import 'tips_widget.dart';
import 'screens/search.dart';

class Home extends StatefulWidget {
  @override
  State createState() {
    return _HomeState();
  }
}

class _HomeState extends State {
  int _currentIndex = 0;
  final List _children = [
    HomepageWidget(),
    TipsWidget(),
    Search(), // replace with dental clinics widget
    SettingsWidget()
  ];

  Future<bool> _onWillPop() async {
    return (await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Confirm Exit?'),
            content: const Text('Are you sure you want to exit the app?'),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text('No'),
              ),
              TextButton(
                onPressed: () => SystemNavigator.pop(),
                child: const Text('Yes'),
              ),
            ],
          ),
        )) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        body: _children[_currentIndex], // new
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: const Color(0xffCCEFFC),
          unselectedItemColor: Colors.black38,
          selectedItemColor: const Color(0xff34346E),
          showSelectedLabels: false,
          showUnselectedLabels: false,
          onTap: onTabTapped,
          currentIndex: _currentIndex,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              title: Text('Home'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.lightbulb),
              title: Text('Tips'),
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.place), title: Text('Place')),
            BottomNavigationBarItem(
                icon: Icon(Icons.more_horiz), title: Text('Settings'))
          ],
        ),
      ),
    );
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}
