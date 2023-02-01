import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:wimc/widget/appBar.dart';
import 'package:wimc/widget/navigationDrawer.dart';

class ScaffoldWidget extends StatelessWidget {
  Widget body;
  FloatingActionButton? floatingActionButton;
  ScaffoldWidget({super.key, required this.body, this.floatingActionButton});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const NavigationDrawerWidget(),
      appBar: const AppBarWidget(),
      floatingActionButton: floatingActionButton,
      body: body,
    );
  }
}
