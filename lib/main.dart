import 'package:flutter/material.dart';
import 'package:wimc/core/res/color.dart';
import 'package:wimc/routes/routes.dart';

void main(List<String> args) {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WIMC',
      debugShowCheckedModeBanner: false,
      theme: AppColors.getTheme,
      initialRoute: Routes.home,
      onGenerateRoute: RouterGenerator.generateRoutes,
    );
  }
}
