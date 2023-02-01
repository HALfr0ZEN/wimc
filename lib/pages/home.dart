import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:wimc/core/res/color.dart';
import 'package:wimc/pages/camera.dart';
import 'package:wimc/pages/clothes/add.dart';
import 'package:wimc/widget/appBar.dart';
import 'package:wimc/widget/clothesTile.dart';
import 'package:wimc/widget/navigationDrawer.dart';
import 'package:wimc/widget/scaffold.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldWidget(
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.secondaryColor,
        child:
            Icon(Icons.add_rounded, size: 40, color: AppColors.backgroundColor),
        onPressed: () => navigateTo(const AddClothes(), context),
      ),
      body: Column(
        children: const [
          ClothesTileWidget(),
          SizedBox(
            height: 10,
          ),
          ClothesTileWidget()
        ],
      ),
    );
  }
}

// () async {
//           await availableCameras().then((value) => Navigator.push(context,
//               MaterialPageRoute(builder: (_) => Camera(cameras: value))));
//         },
