import 'dart:io';
import 'dart:math';
import 'package:camera/camera.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/rendering.dart';
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
  String? clothingLink;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: FractionallySizedBox(
        widthFactor: 0.7,
        child: Container(
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
            clothingLink != null
                ? Image.network(
                    clothingLink!,
                  )
                : SizedBox(width: 50),
            Align(
              alignment: Alignment.topRight,
              child: IconButton(
                icon: Icon(Icons.refresh, color: AppColors.backgroundColor),
                onPressed: loadRandomPart,
              ),
            ),
          ]),
        ),
      ),
    );
  }

  void loadRandomPart() async {
    ListResult result = await FirebaseStorage.instance.ref().listAll();
    var rng = Random();
    int randomInt = rng.nextInt(result.items.length);
    print(randomInt);
    final gen = result.items[randomInt];
    final link = await gen.getDownloadURL();

    setState(() {
      clothingLink = link;
    });
    //load shirt from memory

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
