import 'dart:io';

import 'package:flutter/material.dart';
import 'package:wimc/core/res/color.dart';
import 'package:file_picker/file_picker.dart';

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
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsetsDirectional.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            TextFormField(
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
              keyboardType: TextInputType.number,
              initialValue: '1',
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
              child: Icon(Icons.add_a_photo),
            ),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  // If the form is valid, display a snackbar. In the real world,
                  // you'd often call a server or save the information in a database.
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                        backgroundColor: AppColors.primaryHeaderColor,
                        content: const Text('Processing Data')),
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
