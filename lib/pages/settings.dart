import 'package:flutter/material.dart';
import 'package:wimc/widget/appBar.dart';
import 'package:wimc/widget/navigationDrawer.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      drawer: NavigationDrawerWidget(),
      appBar: AppBarWidget(),
    );
  }
}
