import 'package:flutter/material.dart';
import 'package:wimc/components/navigation.dart';

void main(List<String> args) {
  runApp(const App());
}

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  int getIndex() {
    return _selectedIndex;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WimC',
      home: Scaffold(
        body: pages[_selectedIndex],
        bottomNavigationBar: Navigation(
          setPageIndex: _onItemTapped,
          getPageIndex: getIndex,
        ),
      ),
    );
  }
}
