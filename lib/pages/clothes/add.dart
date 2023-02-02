import 'package:flutter/material.dart';
import 'package:wimc/widget/addClothesForm.dart';
import 'package:wimc/widget/scaffold.dart';

class AddClothes extends StatefulWidget {
  const AddClothes({super.key});

  @override
  State<AddClothes> createState() => _AddClothesState();
}

class _AddClothesState extends State<AddClothes> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return ScaffoldWidget(body: const AddClothesFormWidget());
  }
}
