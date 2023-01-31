import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:wimc/pages/camera.dart';
import 'package:wimc/widget/appBar.dart';
import 'package:wimc/widget/clothesTile.dart';
import 'package:wimc/widget/navigationDrawer.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const NavigationDrawerWidget(),
      appBar: const AppBarWidget(),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () async {
            await availableCameras().then((value) => Navigator.push(context,
                MaterialPageRoute(builder: (_) => Camera(cameras: value))));
          }),
      body: Column(
        children: [
          ClothesTileWidget(),
          const SizedBox(
            height: 10,
          ),
          ClothesTileWidget()
        ],
      ),
    );
  }
}
