import 'package:flutter/material.dart';
import 'package:wimc/widget/appBar.dart';
import 'package:wimc/widget/navigationDrawer.dart';
import 'package:wimc/widget/scaffold.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldWidget(
      body: Placeholder(),
      floatingActionButton: FloatingActionButton(onPressed: () => {}),
    );
  }
}
