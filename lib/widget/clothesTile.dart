import 'dart:io';
import 'package:camera/camera.dart';
import 'dart:core';
import 'package:path/path.dart' as path;
import 'package:flutter/material.dart';
import 'package:wimc/core/res/color.dart';
import 'package:path_provider/path_provider.dart';

class ClothesTileWidget extends StatefulWidget {
  const ClothesTileWidget({super.key});

  @override
  State<ClothesTileWidget> createState() => _ClothesTileWidgetState();
}

class _ClothesTileWidgetState extends State<ClothesTileWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: AppColors.primaryColor,
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryColor.withOpacity(0.4),
            blurRadius: 10,
            spreadRadius: 4,
            offset: const Offset(2, 6),
          )
        ],
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(children: [
        Align(
          alignment: Alignment.topRight,
          child: IconButton(
            icon: Icon(Icons.refresh, color: AppColors.backgroundColor),
            onPressed: loadRandomPart,
          ),
        ),
      ]),
    );
  }

  void addNewPart() async {
    // final cameras = await availableCameras();
    // final firstCamera = cameras.first;
    // const controler = CameraController(firstCamera, ResolutionPreset.max);
    // await controler.initialize();
    // if (!controler.value.isInitialized) {
    //   return Container();
    // }
    // CameraPreview(controler);
    // Directory documentDirectory = await getApplicationDocumentsDirectory();
    // File file =
    //     File(path.join(documentDirectory.path, path.basename("template.png")));
    // await file.writeAsBytes();
  }

  void loadRandomPart() async {
    //load shirt from memory
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    Stream<FileSystemEntity> l = documentDirectory.list();

    // setState(() {
    //   _part = new File(path.join(documentDirectory.path, path.basename()));
    // });
  }
}

// A widget that displays the picture taken by the user.
class DisplayPictureScreen extends StatelessWidget {
  final String imagePath;

  const DisplayPictureScreen({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Display the Picture')),
      // The image is stored as a file on the device. Use the `Image.file`
      // constructor with the given path to display the image.
      body: Image.file(File(imagePath)),
    );
  }
}
