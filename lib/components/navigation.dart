import 'package:flutter/material.dart';
import 'package:wimc/home.dart';
import 'package:wimc/settings.dart';

const List<Widget> pages = <Widget>[
  Home(),
  Settings(),
];

class Navigation extends StatefulWidget {
  final ValueSetter<int> setPageIndex;
  final ValueGetter<int> getPageIndex;
  const Navigation(
      {super.key, required this.setPageIndex, required this.getPageIndex});

  @override
  State<Navigation> createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings),
          label: 'Settings',
        ),
      ],
      currentIndex: widget.getPageIndex(),
      unselectedItemColor: Colors.black,
      selectedItemColor: Colors.amber[800],
      onTap: widget.setPageIndex,
    );
  }
}
