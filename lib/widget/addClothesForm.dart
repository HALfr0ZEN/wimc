import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:wimc/core/res/color.dart';
import 'package:file_picker/file_picker.dart';
import 'package:path/path.dart' as p;

class AddClothesFormWidget extends StatefulWidget {
  const AddClothesFormWidget({super.key});

  @override
  State<AddClothesFormWidget> createState() => _AddClothesFormWidgetState();
}

class _AddClothesFormWidgetState extends State<AddClothesFormWidget> {
  final _formKey = GlobalKey<FormState>();
  String? selectedValue;
  List<File>? selectedFiles;

  @override
  Widget build(BuildContext context) {
    TextEditingController name = TextEditingController();
    TextEditingController quantity = TextEditingController(text: '1');

    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsetsDirectional.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            TextFormField(
              controller: name,
              decoration: const InputDecoration(
                labelText: 'Product name',
              ),
              // The validator receives the text that the user has entered.
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'This is a required field';
                }
                return null;
              },
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: quantity,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Quantity',
              ),
              // The validator receives the text that the user has entered.
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'This is a required field';
                }
                return null;
              },
            ),
            const SizedBox(height: 10),
            DropdownButtonFormField(
              value: selectedValue,
              items:
                  clothingTypes.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (value) => {
                setState(() {
                  selectedValue = value!;
                })
              },
            ),
            Row(
              children: [...imagesBuilder(selectedFiles)],
            ),
            ElevatedButton(
              onPressed: () async {
                FilePickerResult? result =
                    await FilePicker.platform.pickFiles(allowMultiple: true);
                if (result != null) {
                  List<File> files =
                      result.paths.map((path) => File(path!)).toList();
                  setState(() {
                    selectedFiles = files;
                  });
                  return;
                }
              },
              child: const Icon(Icons.add_a_photo),
            ),
            ElevatedButton(
              onPressed: () async {
                if (_formKey.currentState!.validate() &&
                    selectedValue != null &&
                    selectedFiles != null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                        backgroundColor: AppColors.primaryHeaderColor,
                        content: const Text('Processing Data')),
                  );
                  const uuid = Uuid();
                  final storage = FirebaseStorage.instance.ref();

                  List<String> fileIds = [];
                  for (var file in selectedFiles!) {
                    final child =
                        storage.child("${uuid.v1()}${p.extension(file.path)}");
                    final snap = await child.putFile(file);
                    final link = await snap.ref.getDownloadURL();
                    fileIds.add(link);
                  }

                  Map<String, dynamic> dataToSave = {
                    'name': name.text,
                    'quantity': quantity.text,
                    'type': selectedValue!,
                    'file_links': fileIds,
                  };
                  final reference = await FirebaseFirestore.instance
                      .collection('clothes')
                      .add(dataToSave);
                  ScaffoldMessenger.of(context).clearSnackBars();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                        backgroundColor: AppColors.primaryHeaderColor,
                        content: const Text('Done')),
                  );
                }
              },
              child: const Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}

Iterable<Widget> imagesBuilder(List<File>? files) {
  if (files != null && files.isNotEmpty) {
    return files.map(
      (file) => Image(
        image: FileImage(file),
        width: 50,
      ),
    );
  }
  return [SizedBox(width: 10)];
}

List<String> clothingTypes = [
  'Jeans',
  'Jacket',
  'Shirt',
  'T-Shirt',
  'Boots',
  'Hoodie',
  'Cap',
  'Socks',
  'Boxers',
  'Underwear',
  'Bra',
  'Glasses',
  'WristWatch',
  'Necklace'
];
