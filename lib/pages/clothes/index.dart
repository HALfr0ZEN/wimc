import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:wimc/widget/scaffold.dart';

class ShowClothes extends StatefulWidget {
  const ShowClothes({super.key});

  @override
  State<ShowClothes> createState() => _ShowClothesState();
}

class _ShowClothesState extends State<ShowClothes> {
  late List<TableRow> StateData = [];

  @override
  Widget build(BuildContext context) {
    return ScaffoldWidget(
        body: FutureBuilder(
            future: getData(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return DataTable(
                  columns: [
                    DataColumn(
                        label: Text('Name', style: TextStyle(fontSize: 20.0))),
                    DataColumn(
                        label:
                            Text('Quantity', style: TextStyle(fontSize: 20.0))),
                    DataColumn(
                        label: Text('Type', style: TextStyle(fontSize: 20.0))),
                    DataColumn(
                        label: Text('', style: TextStyle(fontSize: 20.0))),
                  ],
                  rows: [...snapshot.data as List<DataRow>],
                );
              }
              return const Center(child: CircularProgressIndicator());
            }));
  }

  Future<List<DataRow>> getData() async {
    CollectionReference _collectionRef =
        FirebaseFirestore.instance.collection('clothes');
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    if (user != null) {
      QuerySnapshot querySnapshot = await _collectionRef.get();

      final data = querySnapshot.docs
          .map((doc) => doc.data() as Map<String, dynamic>)
          .toList();
      List<DataRow> rows = [];
      for (var record in data) {
        if (record == null) continue;
        rows.add(DataRow(
          cells: [
            DataCell(Text(record["name"])),
            DataCell(Text(record["quantity"])),
            DataCell(Text(record["type"])),
            DataCell(IconButton(
                onPressed: () {
                  print(record);
                },
                icon: const Icon(Icons.delete)))
          ],
        ));
      }
      return rows;
    }
    throw "";
  }
}
